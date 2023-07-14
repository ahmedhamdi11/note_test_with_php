import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:notes_with_php_test/errors/failure.dart';
import 'package:path/path.dart';

class ApiServices {
  String baseUrl = 'http://192.168.1.102/php_course/';
  String baseImagesUrl = 'http://192.168.1.102/php_course/uploaded_images/';

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

  Future<Either<Failure, Map<String, dynamic>>> postRequestWithFile({
    required String endPoint,
    required Map data,
    required File image,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$endPoint'),
      );

      var length = await image.length();
      var stream = http.ByteStream(image.openRead());

      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: basename(image.path),
      );

      request.files.add(multipartFile);

      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myRequest = await request.send();

      var response = await http.Response.fromStream(myRequest);

      if (myRequest.statusCode == 200) {
        return right(jsonDecode(response.body));
      } else {
        return left(Failure('error ${myRequest.statusCode}'));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
