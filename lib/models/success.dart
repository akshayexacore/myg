class PostResponse {
  late bool success;
  late String message;

  PostResponse({this.success = false, this.message = ''});

  PostResponse.fromJson(Map<String, dynamic> json) {
    success = json['statusCode'] == 200;
    message = json['message'] ?? '';
  }
}

class FileUploadResponse {
  late bool success;
  late String message;
  late String path;

  FileUploadResponse({this.success = false, this.message = '',this.path = ''});

  FileUploadResponse.fromJson(Map<String, dynamic> json) {
    success = json['statusCode'] == 200;
    message = json['message'] ?? '';
    path = json['data']['filePath'] ?? '';
  }
}

class ClassCalculationResponse {
  late bool success;
  late double amount;

  ClassCalculationResponse({this.success = false, this.amount = 0});

  ClassCalculationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] == true;
    amount = double.tryParse((json['eligible_amount'] ?? 0).toString()) ?? 0;
  }
}