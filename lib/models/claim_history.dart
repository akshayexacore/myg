import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/utils/app_enums.dart';

class ClaimHistoryResponse {
  late bool success;
  late String message;
  late List<ClaimHistory> claims;

  ClaimHistoryResponse({this.success = false, this.message = '', this.claims = const []});

  ClaimHistoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;
    claims = <ClaimHistory>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        claims.add(ClaimHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = message;
    data['data'] = claims.map((v) => v.toJson()).toList();
    return data;
  }
}

class ClaimDetailResponse {
  late bool success;
  late String message;
  ClaimHistory? claim;

  ClaimDetailResponse({this.success = false, this.message = '', this.claim});

  ClaimDetailResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;

    if (json['data'] != null) {
      claim = (ClaimHistory.fromJson(json['data']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = message;
    data['data'] = claim?.toJson();
    return data;
  }
}extension ClaimHistoryCopyWith on ClaimHistory {
  ClaimHistory copyWith({
    String? tripClaimId,
    TripType? tripTypeDetails,
    Employee? approverDetails,
    Employee? userDetails,
    Employee? financeApproverDetails,
    String? tripPurpose,
   List< Branch>? visitBranchDetail,
    List<Category>? categories,
    ClaimStatus? status,
    ClaimStatus? tripHistoryStatus,
    String? pendingFrom,
    String? tripApproverRemarks,
    ClaimStatus? approverStatus,
    ClaimStatus? financeStatus,
    String? tmgId,
    String? date,
    String? finanaceRemarks,
    String? tripApprovedDate,
    String? tripRejectedDate,
    String? financeApprovedDate,
    double? totalAmount,
  }) {
    return ClaimHistory(
      tripClaimId: tripClaimId ?? this.tripClaimId,
      tripTypeDetails: tripTypeDetails ?? this.tripTypeDetails,
      approverDetails: approverDetails ?? this.approverDetails,
      userDetails: userDetails ?? this.userDetails,
      financeApproverDetails: financeApproverDetails ?? this.financeApproverDetails,
      tripPurpose: tripPurpose ?? this.tripPurpose,
      visitBranchDetail: visitBranchDetail ?? this.visitBranchDetail,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      tripHistoryStatus: tripHistoryStatus ?? this.tripHistoryStatus,
      pendingFrom: pendingFrom ?? this.pendingFrom,
      tripApproverRemarks: tripApproverRemarks ?? this.tripApproverRemarks,
      approverStatus: approverStatus ?? this.approverStatus,
      financeStatus: financeStatus ?? this.financeStatus,
      tmgId: tmgId ?? this.tmgId,
      date: date ?? this.date,
      finanaceRemarks: finanaceRemarks ?? this.finanaceRemarks,
      tripApprovedDate: tripApprovedDate ?? this.tripApprovedDate,
      tripRejectedDate: tripRejectedDate ?? this.tripRejectedDate,
      financeApprovedDate: financeApprovedDate ?? this.financeApprovedDate,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}


class ClaimHistory {
  late String tripClaimId;
  TripType? tripTypeDetails;
  Employee? approverDetails;
  Employee? userDetails;
  Employee? financeApproverDetails;
  late String tripPurpose;
  List<Branch>? visitBranchDetail;
  List<Category>? categories;
  late ClaimStatus status;
  late ClaimStatus tripHistoryStatus;
  late String pendingFrom;
  late String tripApproverRemarks;
  late ClaimStatus approverStatus;
  late ClaimStatus financeStatus;
  late String tmgId;
  late String date;
  late String? finanaceRemarks;
  late String tripApprovedDate;
  late String tripRejectedDate;
  late String financeApprovedDate;
  late double totalAmount;

  ClaimHistory(
      {this.tripClaimId = '',
        this.tripTypeDetails,
        this.approverDetails,
        this.userDetails,
        this.finanaceRemarks="",

        this.financeApproverDetails,
        this.tripPurpose = '',
        this.pendingFrom = '',
        this.tripApproverRemarks = '',
        this.visitBranchDetail,
        this.categories,
        this.status = ClaimStatus.none,
        this.tripHistoryStatus = ClaimStatus.none,
        this.approverStatus = ClaimStatus.none,
        this.financeStatus = ClaimStatus.none,
        this.tmgId = '',
        this.date = '',
        this.tripApprovedDate = '',
        this.tripRejectedDate = '',
        this.financeApprovedDate = '',
        this.totalAmount = 0
      });

  ClaimHistory.fromJson(Map<String, dynamic> json) {
    tripClaimId = json['trip_claim_id'] ?? '';
    status = json['trip_status'].toString().toClaimStatus;
    finanaceRemarks=json["finance_remarks"] ??"";
    tripHistoryStatus = json['trip_history_status'].toString().toClaimStatus;
    approverStatus = json['approver_status'].toString().toClaimStatus;
    financeStatus = json['finance_status'].toString().toClaimStatus;
    tmgId = json['tmg_id'] ?? '';
    date = json['date'] ?? '';
    pendingFrom = json['pending_from'] ?? '';
    tripApproverRemarks = json['trip_approver_remarks'] ?? '';
    tripApprovedDate = json['trip_approved_date'] ?? 'NA';
    tripRejectedDate = json['trip_rejected_date'] ?? 'NA';
    financeApprovedDate = json['finance_status_change_date'] ?? 'NA';
    totalAmount = double.tryParse(json['total_amount'].toString()) ?? 0;
    tripTypeDetails = json['trip_type_details'] != null
        ? new TripType.fromJson(json['trip_type_details'])
        : null;
    approverDetails = json['approver_details'] != null
        ? new Employee.fromJson(json['approver_details'])
        : null;
    userDetails = json['user_details'] != null
        ? new Employee.fromJson(json['user_details'])
        : null;
    financeApproverDetails = json['finance_approver_details'] != null
        ? new Employee.fromJson(json['finance_approver_details'])
        : null;
    tripPurpose = json['trip_purpose'] ?? '';
    visitBranchDetail =json['visit_branch_detail'] != null
          ? List<Branch>.from(
              json['visit_branch_detail'].map((x) => Branch.fromJson(x)))
          : null;
    categories = <Category>[];
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_claim_id'] = this.tripClaimId;
    if (this.tripTypeDetails != null) {
      data['trip_type_details'] = this.tripTypeDetails!.toJson();
    }
    if (this.approverDetails != null) {
      data['approver_details'] = this.approverDetails!.toJson();
    }
    data['trip_purpose'] = this.tripPurpose;
    if (this.visitBranchDetail != null) {
      data['visit_branch_detail'] = this.visitBranchDetail!.map((x) => x.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class DuplicateEmployee {
  final int? userId;
  final String? empId;
  final String? empName;
  final String? tripClaimId;
  final String? tripClaimDetailId;
  final bool? isDuplication;

  DuplicateEmployee({
    this.userId,
    this.empId,
    this.empName,
    this.tripClaimId,
    this.tripClaimDetailId,
    this.isDuplication,
  });

  factory DuplicateEmployee.fromJson(Map<String, dynamic> json) {
    return DuplicateEmployee(
      userId: json['user_id'],
      empId: json['emp_id'],
      empName: json['emp_name'],
      tripClaimId: json['trip_claim_id'],
      tripClaimDetailId: json['trip_claim_detail_id'],
      isDuplication: json['is_duplication'],
    );
  }
}