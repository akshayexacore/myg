
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/utils/app_formatter.dart';

class ClaimForm {
  late int id;
  late String storageId;
  late TripType tripType;
  Branch? branch;
  late DateTime createdAt;
  late String purpose;
  late List<Category> categories;

  ClaimForm({
    this.id = 0,
    this.storageId = '',
    required this.tripType,
    this.branch,
    required this.createdAt,
    required this.purpose,
    required this.categories,
  });

ClaimForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storageId = json['storage_id'] ?? '';
    tripType =  TripType.fromJson(json['trip_type']);
    branch = json['branch']!=null ?  Branch.fromJson(json['branch']) : null;
    createdAt =  DateTime.parse(json['created_at']);
    purpose = json['purpose'] ?? '';
    categories = <Category>[];
    if (json['categories'] != null) {
      json['categories'].forEach((v) {
        categories.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['storage_id'] = storageId;
    data['trip_type'] = tripType.toJson();
    data['branch'] = branch?.toJson();
    data['created_at'] = createdAt.toString();
    data['purpose'] = purpose;
    data['categories'] = categories.map((v) => v.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toApiJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['triptype_id'] = tripType.id;
    data['visit_branch_id'] = branch?.id;
    data['trip_purpose'] = purpose;
    data['claim_details'] = categories
        .expand((category) => category.items)
        .toList().map((v) => v.toApiJson()).toList();
    return data;
  }
}


class ClaimFormData {
  String? id;
  int? classId;
  int? policyId;
  DateTime? fromDate;
  DateTime? toDate;
  String? tripFrom;
  String? tripTo;
  String? odoMeterStart;
  String? odoMeterEnd;
  late int noOfEmployees;
  late List<Employee> employees;
  late String remarks;
  late String approverRemarks;
  double? amount;
  double? deductedAmount;
  double? eligibleAmount;
  late List<String> files;
  late String fileError;
  CategoryClass? selectedClass;
  late ClaimStatus status;
  late bool sentForApproval;
  late int rejectionCount;
  late GlobalKey<FormState> formKey;

  ClaimFormData({
    this.id,
    this.classId,
    this.policyId,
    this.fromDate,
    this.toDate,
    this.tripFrom,
    this.tripTo,
    this.odoMeterStart,
    this.odoMeterEnd,
    this.noOfEmployees = 1,
    this.employees = const [],
    this.remarks = '',
    this.fileError = '',
    this.approverRemarks = '',
    this.amount=0,
    this.eligibleAmount=0,
    this.deductedAmount=0,
    this.files = const [],
    this.selectedClass,
    this.status = ClaimStatus.none,
    this.sentForApproval = false,
    this.rejectionCount = 0,
  }): formKey = GlobalKey<FormState>();

  ClaimFormData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    policyId = json['policy_id'];
    fromDate = json['from_date']!=null ? DateTime.tryParse(json['from_date']) : null;
    toDate = json['to_date']!=null ? DateTime.tryParse(json['to_date']) : null;
    tripFrom = json['trip_from'];
    tripTo = json['trip_to'];
    odoMeterStart = json['odo_meter_start'];
    odoMeterEnd = json['odo_meter_end'];
    noOfEmployees = json['no_of_employees'] ?? 1;
    employees = <Employee>[];
    if (json['employees'] != null) {
      json['employees'].forEach((v) {
        employees.add(Employee.fromJson(v));
      });
    }
    remarks = json['remarks'] ?? '';
    approverRemarks = json['approver_remarks'] ?? '';
    amount = json['amount'] ?? json['unit_amount'];
    deductedAmount=json["deduct_amount"]??0;
    eligibleAmount = null;
    files = <String>[];
    if (json['files'] != null) {
      json['files'].forEach((v) {
        files.add(v);
      });
    }
    if(json['selected_class']!=null){
      selectedClass = CategoryClass.fromJson(json['selected_class']);
    }
    status = json['status'].toString().toClaimStatus;
    fileError = '';
    formKey = GlobalKey<FormState>();
  }

  ClaimFormData.fromApiJson(Map<String, dynamic> json) {
    id = json['trip_claim_details_id'];
    status = json['status'].toString().toClaimStatus;
    classId = json['class_id'];
    policyId = json['policy_id'];
    fromDate = json['from_date']!=null ? DateTime.tryParse(json['from_date']) : null;
    toDate = json['to_date']!=null ? DateTime.tryParse(json['to_date']) : null;
    fromDate = json['document_date']!=null ? DateTime.tryParse(json['document_date']) : null;
    tripFrom = json['trip_from'];
    tripTo = json['trip_to'];
    odoMeterStart = json['start_meter']!=null ? json['start_meter'].toString() : null;
    odoMeterEnd = json['end_meter']!=null ? json['end_meter'].toString() : null;
    noOfEmployees = json['no_of_persons'] ?? (json['no_of_person'] ?? (json['no_of_employees'] ?? 1));
    sentForApproval = json['send_approver_flag'] ?? false;
    rejectionCount = json['rejection_count'] ?? 0;
    employees = <Employee>[];
    if (json['person_details'] != null) {
      json['person_details'].forEach((v) {
        employees.add(Employee.fromJson(v));
      });
    }
    remarks = json['remarks'] ?? '';
    approverRemarks = json['approver_remarks'] ?? '';
    amount = double.tryParse(json['unit_amount'].toString()) ?? 0;
    eligibleAmount = double.tryParse(json['eligible_amount'].toString()) ?? 0;
    files = <String>[];
    if(json['file_url']!=null){
      files = [json['file_url']];
    }
    /*if (json['files'] != null) {
      json['files'].forEach((v) {
        files.add(v);
      });
    }*/
    if(json['policy_details']!=null){
      selectedClass = CategoryClass.fromJson(json['policy_details']);
    }

    classId = selectedClass?.id;
    policyId = selectedClass?.policy?.id;
    fileError = '';
    formKey = GlobalKey<FormState>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['trip_claim_details_id'] = id;
    data['class_id'] = classId;
    data['policy_id'] = policyId;
    data['from_date'] = fromDate.toString();
    data['to_date'] = toDate.toString();
    data['trip_from'] = tripFrom;
    data['trip_to'] = tripTo;
    data['odo_meter_start'] = odoMeterStart;
    data['odo_meter_end'] = odoMeterEnd;
    data['no_of_employees'] = noOfEmployees;
    data['employees'] = employees.map((v) => v.toJson()).toList();
    data['remarks'] = remarks;
    data['amount'] = amount;
    data['files'] = files;
    data['selected_class'] = selectedClass?.toJson();
    data['policy_details'] = selectedClass?.toJson();
    return data;
  }

  Map<String, dynamic> toApiJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['trip_claim_details_id'] = id;
    data['class_id'] = classId;
    data['policy_id'] = policyId;
    data['from_date'] = fromDate!=null ? AppFormatter.formatYYYYMMDD(fromDate!) : null;
    data['to_date'] = toDate!=null ? AppFormatter.formatYYYYMMDD(toDate!) : null;
    data['trip_from'] = tripFrom;
    data['trip_to'] = tripTo;
    data['document_date'] = fromDate!=null ? AppFormatter.formatYYYYMMDD(fromDate!) : null;
    data['start_meter'] = odoMeterStart;
    data['end_meter'] = odoMeterEnd;
    data['qty'] = 1;
    data['no_of_person'] = noOfEmployees;
    data['person_details'] = employees.map((v) => v.toJson()).toList();
    data['remarks'] = remarks;
    data['unit_amount'] = amount;
    data['file_url'] = files.isNotEmpty ? files.first : null;
    data['policy_details'] = selectedClass?.toJson();
    return data;
  }
}
