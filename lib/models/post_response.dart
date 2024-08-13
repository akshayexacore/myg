class PostResponse {
  late bool success;
  late String message;

  PostResponse({this.success = false, this.message = '',});

  PostResponse.fromJson(Map<String, dynamic> json) {
    message = json['data']['message'];
    success = json['data']['status'];
  }

  PostResponse.fromFavJson(Map<String, dynamic> json) {
    message = json['data']['detail'] ?? json['data']['status'];
    success = json['detail'] == 'success';
  }

  PostResponse.fromBillUploadJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['detail'] == 'success';
  }

  PostResponse.fromBookVoucherJson(Map<String, dynamic> json) {
    message = json['message'] ?? (json['data']['error'] ?? '');
    success = json['detail'] == 'success';
  }

  PostResponse.fromInterestEventJson(Map<String, dynamic> json) {
    message = json['message'] ?? (json['data']['message'] ?? '');
    success = json['detail'] == 'success';
  }
}