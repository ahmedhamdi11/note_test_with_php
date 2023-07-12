import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:notes_with_php_test/errors/failure.dart';

class ApiServices {
  String baseUrl = 'http://192.168.1.102/php_course/';

  Future<Either<Failure, Map<String, dynamic>>> post({
    required String endPoint,
    required Map data,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl$endPoint'),
        body: data,
      );
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'success') {
        return right(jsonData);
      } else {
        String errMessage = jsonData['message'];
        return left(Failure(errMessage));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
