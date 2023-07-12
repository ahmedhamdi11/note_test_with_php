String? checkInputValidation(String value, int min, int max) {
  if (value.isEmpty) {
    return 'this field cannot be empty!';
  } else if (value.length > max) {
    return 'number of characters cannot be grater than $max';
  } else if (value.length < min) {
    return 'number of characters cannot be fewer than $min';
  } else {
    return null;
  }
}
