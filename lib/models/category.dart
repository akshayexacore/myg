import 'package:travel_claim/models/claim_form.dart';

class CategoryResponse {
  late String message;
  late List<Category> categories;
  late bool success;

  CategoryResponse(
      {this.message = '', this.categories = const [], this.success = false});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    success = json['statusCode'] == 200;
    categories = <Category>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        categories.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = categories.map((v) => v.toJson()).toList();
    data['success'] = success;
    return data;
  }
}

class Category {
  late int id;
  late String name;
  late bool hasTripFrom;
  late bool hasTripTo;
  late bool hasFromDate;
  late bool hasToDate;
  late bool hasDocumentDate;
  late bool hasStartMeter;
  late bool hasEndMeter;
  late String imageUrl;
  late List<CategoryClass>? classes;
  late List<ClaimFormData> items;

  Category({this.id = 0,
    this.name = '',
    this.hasTripFrom = false,
    this.hasTripTo = false,
    this.hasFromDate = false,
    this.hasToDate = false,
    this.hasDocumentDate = false,
    this.hasStartMeter = false,
    this.hasEndMeter = false,
    this.imageUrl = '',
    this.classes,
    this.items = const []
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['category_id'];
    name = json['category_name'];
    hasTripFrom = json['trip_from_flag'];
    hasTripTo = json['trip_to_flag'];
    hasFromDate = json['from_date_flag'];
    hasToDate = json['to_date_flag'];
    hasDocumentDate = json['document_date_flag'];
    hasStartMeter = json['start_meter_flag'];
    hasEndMeter = json['end_meter_flag'];
    imageUrl = json['image_url'];
    classes = <CategoryClass>[];
    if (json['subcategorydetails'] != null) {

      json['subcategorydetails'].forEach((v) {
        classes!.add(CategoryClass.fromJson(v));
      });
    }

    items = <ClaimFormData>[];
    if (json['items'] != null) {
      items = <ClaimFormData>[];
      json['items'].forEach((v) {
        items.add(ClaimFormData.fromJson(v));
      });
    }
    items = <ClaimFormData>[];
    if (json['claim_details'] != null) {

      json['claim_details'].forEach((v) {
        items.add(ClaimFormData.fromApiJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = id;
    data['category_name'] = name;
    data['trip_from_flag'] = hasTripFrom;
    data['trip_to_flag'] = hasTripTo;
    data['from_date_flag'] = hasFromDate;
    data['to_date_flag'] = hasToDate;
    data['document_date_flag'] = hasDocumentDate;
    data['start_meter_flag'] = hasStartMeter;
    data['end_meter_flag'] = hasEndMeter;
    data['image_url'] = imageUrl;
    data['subcategorydetails'] =
        classes?.map((v) => v.toJson()).toList();
    data['items'] = items.map((v) => v.toJson()).toList();
    data['claim_details'] = items.map((v) => v.toApiJson()).toList();
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CategoryClass {
  late int id;
  late String name;
  late String status;
  Policy? policy;

  CategoryClass({this.id = 0, this.name = '', this.status = '', this.policy});

  CategoryClass.fromJson(Map<String, dynamic> json) {
    id = json['subcategory_id'] ?? json['sub_category_id'] ?? 0;
    name = json['subcategory_name'] ?? json['sub_category_name'] ?? '';
    status = json['status'] ?? '';
    policy = json['policies'] != null
        ? Policy.fromJson(json['policies'])
        : json['grade_type']!=null ? Policy.fromJson(json) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subcategory_id'] = id;
    data['subcategory_name'] = name;
    data['status'] = status;
    if (policy != null) {
      data['policies'] = policy!.toJson();
    }
    return data;
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryClass &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Policy {
  late int id;
  late int gradeId;
  late String gradeType;
  late String gradeClass;
  double? gradeAmount;
  late String approver;
  late String status;

  Policy({this.id = 0,
    this.gradeId = 0,
    this.gradeType = '',
    this.gradeClass = '',
    this.gradeAmount,
    this.approver = '',
    this.status = ''});

  Policy.fromJson(Map<String, dynamic> json) {
    id = json['policy_id'] ?? 0;
    gradeId = json['grade_id'] ?? 0;
    gradeType = json['grade_type'] ?? '';
    gradeClass = json['grade_class'] ?? '';
    gradeAmount = json['grade_amount']!=null ? double.tryParse(json['grade_amount'].toString()) : null;
    approver = json['approver'] ?? '';
    status = json['status'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['policy_id'] = id;
    data['grade_id'] = gradeId;
    data['grade_type'] = gradeType;
    data['grade_class'] = gradeClass;
    data['grade_amount'] = gradeAmount;
    data['approver'] = approver;
    data['status'] = status;
    return data;
  }
}
