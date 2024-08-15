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

class ClaimHistory {
  late String tripClaimId;
  TripType? tripTypeDetails;
  Employee? approverDetails;
  Employee? financeApproverDetails;
  late String tripPurpose;
  Branch? visitBranchDetail;
  List<Category>? categories;
  late ClaimStatus status;
  late ClaimStatus approverStatus;
  late ClaimStatus financeStatus;
  late String tmgId;
  late String date;
  late String tripApprovedDate;
  late String tripRejectedDate;
  late String financeApprovedDate;
  late double totalAmount;

  ClaimHistory(
      {this.tripClaimId = '',
        this.tripTypeDetails,
        this.approverDetails,
        this.financeApproverDetails,
        this.tripPurpose = '',
        this.visitBranchDetail,
        this.categories,
        this.status = ClaimStatus.none,
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
    approverStatus = json['approver_status'].toString().toClaimStatus;
    financeStatus = json['finance_status'].toString().toClaimStatus;
    tmgId = json['tmg_id'] ?? '';
    date = json['date'] ?? '';
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
    financeApproverDetails = json['finance_approver_details'] != null
        ? new Employee.fromJson(json['finance_approver_details'])
        : null;
    tripPurpose = json['trip_purpose'] ?? '';
    visitBranchDetail = json['visit_branch_detail'] != null
        ? new Branch.fromJson(json['visit_branch_detail'])
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
      data['visit_branch_detail'] = this.visitBranchDetail!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

