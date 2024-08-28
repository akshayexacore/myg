import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/utils/app_formatter.dart';

class AdvanceHistoryResponse {
  late bool success;
  late String message;
  late List<AdvanceHistory> advances;

  AdvanceHistoryResponse({this.success = false, this.message = '', this.advances = const []});

  AdvanceHistoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;
    advances = <AdvanceHistory>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        advances.add(AdvanceHistory.fromJson(v));
      });
    }
  }
}

class AdvanceDetailResponse {
  late bool success;
  late String message;
  AdvanceHistory? advance;

  AdvanceDetailResponse({this.success = false, this.message = '', this.advance});

  AdvanceDetailResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;

    if (json['data'] != null) {
      advance = (AdvanceHistory.fromJson(json['data']));
    }
  }

}

class AdvanceHistory {
  late String id;
  TripType? tripTypeDetails;
  late String tripPurpose;
  Branch? visitBranchDetail;
  late ClaimStatus status;
  late String date;
  late String remarks;
  late double totalAmount;

  AdvanceHistory(
      {this.id = '',
        this.tripTypeDetails,
        this.tripPurpose = '',
        this.visitBranchDetail,
        this.status = ClaimStatus.none,
        this.date = '',
        this.totalAmount = 0
      });

  AdvanceHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    status = json['status'].toString().toClaimStatus;
    remarks = json['remarks'] ?? '';
    date = AppFormatter.formatDDMMYYYY(DateTime.parse(json['request_date'] ?? ''));
    totalAmount = double.tryParse(json['amount'].toString()) ?? 0;
    tripTypeDetails = json['triptype_details'] != null
        ? new TripType.fromJson(json['triptype_details'])
        : null;
    tripPurpose = json['trip_purpose'] ?? '';
    visitBranchDetail = json['branch_details'] != null
        ? new Branch.fromJson(json['branch_details'])
        : null;
  }
}

