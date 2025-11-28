import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/utils/app_formatter.dart';

class ClaimForm {
   int? id;
   String? storageId;
   TripType? tripType;
 List< Branch>? branch;
   DateTime? createdAt;
   String? purpose;
   List<Category>? categories;

  ClaimForm({
    this.id = 0,
    this.storageId = '',
     this.tripType,
    this.branch,
     this.createdAt,
     this.purpose,
     this.categories,
  });

  ClaimForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storageId = json['storage_id'] ?? '';
    tripType = TripType.fromJson(json['trip_type']);
    // branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    createdAt = DateTime.parse(json['created_at']);
    purpose = json['purpose'] ?? '';
    branch = <Branch>[];
    if (json['branch'] != null) {
      json['branch'].forEach((v) {
        branch!.add(Branch.fromJson(v));
      });
    }
    categories = <Category>[];
    if (json['categories'] != null) {
      json['categories'].forEach((v) {
        categories?.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['storage_id'] = storageId;
    data['trip_type'] = tripType?.toJson();
    data['branch'] =branch?.map((e) => e.toJson()).toList();
    data['created_at'] = createdAt.toString();
    data['purpose'] = purpose;
    data['categories'] = categories?.map((v) => v.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toApiJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['triptype_id'] = tripType?.id;
    data['visit_branch_id'] = branch?.map((e) => e.id).toList();
    data['trip_purpose'] = purpose;
   data['claim_details'] = categories?.expand((category) {
  final categoryId = category.id;
  return category.items?.map((item) {
    item.categorId = categoryId; // ✅ inject category_id
    return item.toApiJson();
  }) ?? [];
}).toList() ?? [];

      
  return data;
  }
  
}

class ClaimFormData {
  String? id;
  int? categorId;
  int? classId;
  int? policyId;
  DateTime? fromDate;
  DateTime? toDate;
  String? tripFrom;
  String? tripTo;
  String? fromLat;
  String? fromLong;
  String? odoMeterStart;
  String? odoMeterEnd;
  bool? isFrmdateEmpty;
  bool? isToDateIsEmpty;
  late int noOfEmployees;
  late List<Employee> employees;
   String? remarks;
   String? approverRemarks;
  double? amount;
  double? totalAmount;
  double? deductedAmount;
  double? eligibleAmount;
   List<String>? files;
  late String fileError;
  CategoryClass? selectedClass;
  late ClaimStatus status;
  String? approverId;
  late bool sentForApproval;
   bool? isEnableSendApproval;
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
    this.isFrmdateEmpty = false,
    this.isToDateIsEmpty = false,
    this.noOfEmployees = 1,
    this.employees = const [],
    this.remarks = '',
    this.fromLat,
    this.fromLong,
    this.fileError = '',
    this.approverRemarks = '',
    this.amount = 0,
    this.totalAmount=0,
    this.eligibleAmount = 0,
    this.deductedAmount = 0,
    this.files = const [],
    this.selectedClass,
    this.status = ClaimStatus.none,
    this.sentForApproval = false,
    this.isEnableSendApproval = false,
    this.approverId = "",
    this.rejectionCount = 0,
  }) : formKey = GlobalKey<FormState>();

  ClaimFormData.fromJson(Map<String, dynamic> json) {
    debugPrint("the deduct amount${json["deduct_amount"]}");
    debugPrint("the json lat${json['lat']},${json['lon']}");
    id = json['id'];
    categorId = json['category_id'];
  fromLat = json['lat']?.toString();
fromLong = json['lon']?.toString();

    classId = json['class_id'];
    policyId = json['policy_id'];
    fromDate =
        json['from_date'] != null ? DateTime.tryParse(json['from_date']) : null;
    toDate =
        json['to_date'] != null ? DateTime.tryParse(json['to_date']) : null;
    tripFrom = json['trip_from']?.toString() ?? '';
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
    amount = json['amount'] ?? json['unit_amount']??json['amount'];
    deductedAmount = json["deduct_amount"] ?? 0;
    debugPrint("the deduct amount${json["deduct_amount"]}");
    eligibleAmount = null;
    files = <String>[];
    if (json['files'] != null) {
      json['files'].forEach((v) {
        files?.add(v);
      });
    }
    if (json['selected_class'] != null) {
      selectedClass = CategoryClass.fromJson(json['selected_class']);
    }
    status = json['status'].toString().toClaimStatus;
    fileError = '';
    formKey = GlobalKey<FormState>();
  }

  ClaimFormData.fromApiJson(Map<String, dynamic> json) {
     debugPrint("the lat long${json['lat']?.toString()}");
    
    id = json['trip_claim_details_id'];
    categorId=json['category_id'];
   fromLat = json['lat']?.toString();
fromLong = json['lon']?.toString();
    debugPrint("the json lat$fromLat,$fromLong");
    status = json['status'].toString().toClaimStatus;
    approverId = json["approver_id"].toString();
    classId = json['class_id'];
    policyId = json['policy_id'];
    fromDate =
        json['from_date'] != null ? DateTime.tryParse(json['from_date']) : null;
    toDate =
        json['to_date'] != null ? DateTime.tryParse(json['to_date']) : null;
    fromDate = json['document_date'] != null
        ? DateTime.tryParse(json['document_date'])
        : null;
    tripFrom = json['trip_from']?.toString() ?? '';
    tripTo = json['trip_to'];
    odoMeterStart =
        json['start_meter'] != null ? json['start_meter'].toString() : null;
    odoMeterEnd =
        json['end_meter'] != null ? json['end_meter'].toString() : null;
    noOfEmployees = json['no_of_persons'] ??
        (json['no_of_person'] ?? (json['no_of_employees'] ?? 1));
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
    deductedAmount = double.tryParse(json['deduct_amount'].toString()) ?? 0;
    eligibleAmount = double.tryParse(json['eligible_amount'].toString()) ?? 0;
    files = <String>[];
    if (json['file_url'] != null) {
      files = [json['file_url']];
    }
    /*if (json['files'] != null) {
      json['files'].forEach((v) {
        files.add(v);
      });
    }*/
    if (json['policy_details'] != null) {
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
    data['category_id'] = categorId;
    data['trip_claim_details_id'] = id;
    data['class_id'] = classId;
    data["approver_id"] = approverId;
    data['policy_id'] = policyId;
    data['from_date'] = fromDate.toString();
    data['to_date'] = toDate.toString();
    data['trip_from'] = tripFrom;
    data['trip_to'] = tripTo;
    data['lat']=fromLat;
    data['lon']=fromLong;
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
    debugPrint("dddddddddddddd");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['trip_claim_details_id'] = id;
    data["category_id"]=categorId;
    
    data['class_id'] = classId;
    data['policy_id'] = policyId;
     data['lat']=fromLat;
    data['lon']=fromLong;
    data['from_date'] =
        fromDate != null ? AppFormatter.formatYYYYMMDD(fromDate!) : null;
    data['to_date'] =
        toDate != null ? AppFormatter.formatYYYYMMDD(toDate!) : null;
    data['trip_from'] = tripFrom;
    data['trip_to'] = tripTo;
    data['document_date'] =
        fromDate != null ? AppFormatter.formatYYYYMMDD(fromDate!) : null;
    data['start_meter'] = odoMeterStart;
    data['end_meter'] = odoMeterEnd;
    data['qty'] = 1;
    data['no_of_person'] = noOfEmployees;
    data['person_details'] = employees.map((v) => v.toJson()).toList();
    data['remarks'] = remarks;
    data['unit_amount'] = amount;
    data['file_url'] = files?.isNotEmpty==true ? files?.first : null;
    data['policy_details'] = selectedClass?.toJson();
    return data;
  }
  ClaimFormData copyWith({
  String? id,
  int? classId,
  int? policyId,
  DateTime? fromDate,
  DateTime? toDate,
  String? tripFrom,
  String? tripTo,
  String? odoMeterStart,
  String? odoMeterEnd,
  bool? isFrmdateEmpty,
  bool? isToDateIsEmpty,
  int? noOfEmployees,
  List<Employee>? employees,
  String? remarks,
  String? approverRemarks,
  double? amount,
  double? deductedAmount,
  double? eligibleAmount,
  List<String>? files,
  String? fileError,
  CategoryClass? selectedClass,
  ClaimStatus? status,
  String? approverId,
  bool? sentForApproval,
  bool? isEnableSendApproval,
  int? rejectionCount,
  GlobalKey<FormState>? formKey,
}) {
  return ClaimFormData(
    id: id ?? this.id,
    classId: classId ?? this.classId,
    policyId: policyId ?? this.policyId,
    fromDate: fromDate ?? this.fromDate,
    toDate: toDate ?? this.toDate,
    tripFrom: tripFrom ?? this.tripFrom,
    tripTo: tripTo ?? this.tripTo,
    odoMeterStart: odoMeterStart ?? this.odoMeterStart,
    odoMeterEnd: odoMeterEnd ?? this.odoMeterEnd,
    isFrmdateEmpty: isFrmdateEmpty ?? this.isFrmdateEmpty,
    isToDateIsEmpty: isToDateIsEmpty ?? this.isToDateIsEmpty,
    noOfEmployees: noOfEmployees ?? this.noOfEmployees,
    employees: employees ?? this.employees,
    remarks: remarks ?? this.remarks,
    approverRemarks: approverRemarks ?? this.approverRemarks,
    amount: amount ?? this.amount,
    deductedAmount: deductedAmount ?? this.deductedAmount,
    eligibleAmount: eligibleAmount ?? this.eligibleAmount,
    files: files ?? this.files,
    fileError: fileError ?? this.fileError,
    selectedClass: selectedClass ?? this.selectedClass,
    status: status ?? this.status,
    approverId: approverId ?? this.approverId,
    sentForApproval: sentForApproval ?? this.sentForApproval,
    rejectionCount: rejectionCount ?? this.rejectionCount,
    isEnableSendApproval:isEnableSendApproval??this.isEnableSendApproval 
  )..formKey = formKey ?? this.formKey;
}

}



class ClaimResponse {
  final String? message;
  final int? statusCode;
  final ClaimData? data;
  final String? success;

  ClaimResponse({
    this.message,
    this.statusCode,
    this.data,
    this.success,
  });

  factory ClaimResponse.fromJson(Map<String, dynamic> json) {
    return ClaimResponse(
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
      data: json['data'] != null ? ClaimData.fromJson(json['data']) : null,
      success: json['success'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'statusCode': statusCode,
      'data': data?.toJson(),
      'success': success,
    };
  }

  ClaimResponse copyWith({
    String? message,
    int? statusCode,
    ClaimData? data,
    String? success,
  }) {
    return ClaimResponse(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
      success: success ?? this.success,
    );
  }
}

class ClaimData {
  final String? tripClaimId;
  final String? tripClaimDetailId;

  ClaimData({
    this.tripClaimId,
    this.tripClaimDetailId,
  });

  factory ClaimData.fromJson(Map<String, dynamic> json) {
    return ClaimData(
      tripClaimId: json['trip_claim_id'] as String?,
      tripClaimDetailId: json['trip_claim_detail_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_claim_id': tripClaimId,
      'trip_claim_detail_id': tripClaimDetailId,
    };
  }

  ClaimData copyWith({
    String? tripClaimId,
    String? tripClaimDetailId,
  }) {
    return ClaimData(
      tripClaimId: tripClaimId ?? this.tripClaimId,
      tripClaimDetailId: tripClaimDetailId ?? this.tripClaimDetailId,
    );
  }
}
