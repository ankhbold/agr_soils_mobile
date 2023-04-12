class CustomException implements Exception {
  String? errorMsg;
  int? statusCode;
  CustomException({this.errorMsg, this.statusCode});

  @override
  String toString() {
    return errorMsg!;
  }
}
