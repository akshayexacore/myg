class NotificationResponse {
  late bool success;
  late String message;
  late List<AppNotification> notifications;

  NotificationResponse({this.success = false, this.message = '', this.notifications = const []});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;
    notifications = <AppNotification>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        notifications.add(AppNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = message;
    data['data'] = notifications.map((v) => v.toJson()).toList();
    return data;
  }
}

class AppNotification {
  late String tripClaimId;
  late String message;
  late String status;
  late String viewType;
  late String time;

  AppNotification({
    required this.tripClaimId,
    required this.message,
    required this.status,
    required this.viewType,
    required this.time,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      tripClaimId: json['trip_claim_id'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      viewType: json['view_type'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_claim_id': tripClaimId,
      'message': message,
      'status': status,
      'view_type': viewType,
      'time': time,
    };
  }
}

class NotificationCountResponse {
  late bool success;
  late String message;
  late int notifications;

  NotificationCountResponse({this.success = false, this.message = '',this.notifications = 0});

  NotificationCountResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;
    notifications = json['data'] ?? 0;
  }
}

