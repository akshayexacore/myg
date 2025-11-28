
class DraftListResponse {
  late bool success;
  late String message;
  List<DraftListModel>? claimList;

  DraftListResponse({this.success = false, this.message = '', this.claimList});

  DraftListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;

    if (json['data'] != null && json['data'] is List) {
      claimList = (json['data'] as List<dynamic>)
          .map((e) => DraftListModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'detail': message,
      'data': claimList?.map((e) => e.toJson()).toList(),
    };
  }
}



class DraftListModel {
  String? tripClaimId;
  String? tmgId;
  String? tripPurpose;
  String? date;
  String? tripStatus;
  String? tripHistoryStatus;
  String? tripApproverRemarks;
  String? financeRemarks;
  String? totalAmount;
  String? tripApprovedDate;
  String? tripRejectedDate;
  String? approverStatus;
  String? financeStatus;
  String? financeStatusChangeDate;
  String? remainderMessage;
  String? expiryDate;
  TripTypeDetails? tripTypeDetails;
  List<VisitBranchDetail>? visitBranchDetail;
  int? lastDate;
  bool? isRemider;

  DraftListModel({
    this.tripClaimId,
    this.tmgId,
    this.tripPurpose,
    this.date,
    this.tripStatus,
    this.tripHistoryStatus,
    this.tripApproverRemarks,
    this.financeRemarks,
    this.totalAmount,
    this.tripApprovedDate,
    this.tripRejectedDate,
    this.approverStatus,
    this.financeStatus,
    this.financeStatusChangeDate,
    this.tripTypeDetails,
    this.visitBranchDetail,
    this.lastDate,
    this.isRemider,
    this.remainderMessage,
    this.expiryDate,
  });

  factory DraftListModel.fromJson(Map<String, dynamic> json) {
    return DraftListModel(
      tripClaimId: json['trip_claim_id'],
      tmgId: json['tmg_id'],
      tripPurpose: json['trip_purpose'],
      date: json['date'],
      tripStatus: json['trip_status'],
      tripHistoryStatus: json['trip_history_status'],
      tripApproverRemarks: json['trip_approver_remarks'],
      financeRemarks: json['finance_remarks'],
      totalAmount: json['total_amount'],
      tripApprovedDate: json['trip_approved_date'],
      isRemider: json['reminder'],
      expiryDate: json['expiry_date'],
      remainderMessage: json["remainder_message"],
      tripRejectedDate: json['trip_rejected_date'],
      approverStatus: json['approver_status'],
      financeStatus: json['finance_status'],
      financeStatusChangeDate: json['finance_status_change_date'],
      tripTypeDetails: json['trip_type_details'] != null
          ? TripTypeDetails.fromJson(json['trip_type_details'])
          : null,
      visitBranchDetail: (json['visit_branch_detail'] as List<dynamic>?)
          ?.map((e) => VisitBranchDetail.fromJson(e))
          .toList(),
      lastDate: json['last_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_claim_id': tripClaimId,
      'tmg_id': tmgId,
      'trip_purpose': tripPurpose,
      'date': date,
      'trip_status': tripStatus,
      'trip_history_status': tripHistoryStatus,
      'trip_approver_remarks': tripApproverRemarks,
      'finance_remarks': financeRemarks,
      'total_amount': totalAmount,
      'trip_approved_date': tripApprovedDate,
      'trip_rejected_date': tripRejectedDate,
      'approver_status': approverStatus,
      'finance_status': financeStatus,
      'finance_status_change_date': financeStatusChangeDate,
      'trip_type_details': tripTypeDetails?.toJson(),
      'visit_branch_detail': visitBranchDetail?.map((e) => e?.toJson()).toList(),
      'last_date': lastDate,
    };
  }
}
class TripTypeDetails {
  int? triptypeId;
  String? triptypeName;

  TripTypeDetails({this.triptypeId, this.triptypeName});

  factory TripTypeDetails.fromJson(Map<String, dynamic> json) {
    return TripTypeDetails(
      triptypeId: json['triptype_id'],
      triptypeName: json['triptype_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'triptype_id': triptypeId,
      'triptype_name': triptypeName,
    };
  }
}
class VisitBranchDetail {
  int? branchId;
  String? branchName;

  VisitBranchDetail({this.branchId, this.branchName});

  factory VisitBranchDetail.fromJson(Map<String, dynamic> json) {
    return VisitBranchDetail(
      branchId: json['branch_id'],
      branchName: json['branch_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branch_id': branchId,
      'branch_name': branchName,
    };
  }
}
