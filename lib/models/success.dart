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