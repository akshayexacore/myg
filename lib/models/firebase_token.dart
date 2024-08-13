class FirebaseTokenResponse {
  const FirebaseTokenResponse({
    this.success = false,
    this.message = '',
  });

  final bool success;
  final String message;

  factory FirebaseTokenResponse.fromJson(Map<String, dynamic> json) {
    return FirebaseTokenResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? '',
    );
  }
}
