import 'package:logger/logger.dart';
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
  int? id;
  String? name;
  int? categoryId;
  bool? hasTripFrom;
  bool? hasTripTo;
  bool? hasFromDate;
  bool? hasToDate;
  bool? hasDocumentDate;
  bool? hasStartMeter;
  bool? hasEndMeter;
  bool? hasClass;
  int? noOfDays;
  String? imageUrl;
  List<CategoryClass>? classes;
  List<ClaimFormData>? items;

  Category(
      {this.id = 0,
      this.name = '',
      this.hasTripFrom = false,
      this.hasTripTo = false,
      this.hasFromDate = false,
      this.hasToDate = false,
      this.hasDocumentDate = false,
      this.hasStartMeter = false,
      this.hasEndMeter = false,
      this.hasClass = false,
      this.noOfDays = 0,
      this.imageUrl = '',
      this.classes,
      this.items = const []});

  Category.fromJson(Map<String, dynamic> json) {


    id = json['category_id'];
    categoryId=json['category_id'];
    name = json['category_name'];
    hasTripFrom = json['trip_from_flag'];
    hasTripTo = json['trip_to_flag'];
    hasFromDate = json['from_date_flag'];
    hasToDate = json['to_date_flag'];
    hasDocumentDate = json['document_date_flag'];
    hasStartMeter = json['start_meter_flag'];
    hasEndMeter = json['end_meter_flag'];
    hasClass = json['class_flg'];
    imageUrl = json['image_url'];
    noOfDays = json['no_of_days'];
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
        print("sssssssssssssssss");
        items?.add(ClaimFormData.fromJson(v));
      });
    }

    if (json['claim_details'] != null) {
      items = <ClaimFormData>[];
      json['claim_details'].forEach((v) {
        print("ddddddd");
        items?.add(ClaimFormData.fromApiJson(v));
      });
    }
  }
  @override
  String toString() {
    return '''
Category(
  id: $id,
  name: $name,
  hasTripFrom: $hasTripFrom,
  hasTripTo: $hasTripTo,
  hasFromDate: $hasFromDate,
  hasToDate: $hasToDate,
  hasDocumentDate: $hasDocumentDate,
  hasStartMeter: $hasStartMeter,
  hasEndMeter: $hasEndMeter,
  hasClass: $hasClass,
  noOfDays: $noOfDays,
  imageUrl: $imageUrl,
  classes: $classes,
  items: $items
)
''';
  }

  Map<String, dynamic> toJson() {
    print("calling to json");
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
    data['class_flg'] = hasClass;
    data['image_url'] = imageUrl;
    data['no_of_days'] = noOfDays;
    data['subcategorydetails'] = classes?.map((v) => v.toJson()).toList();
    data['items'] = items?.map((v) => v.toJson()).toList();
    data['claim_details'] = items?.map((v) => v.toApiJson()).toList();
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

extension CategoryCopyWith on Category {
  Category copyWith({
    int? id,
    String? name,
    bool? hasTripFrom,
    bool? hasTripTo,
    bool? hasFromDate,
    bool? hasToDate,
    bool? hasDocumentDate,
    bool? hasStartMeter,
    bool? hasEndMeter,
    bool? hasClass,
    int? noOfDays,
    String? imageUrl,
    List<CategoryClass>? classes,
    List<ClaimFormData>? items,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      hasTripFrom: hasTripFrom ?? this.hasTripFrom,
      hasTripTo: hasTripTo ?? this.hasTripTo,
      hasFromDate: hasFromDate ?? this.hasFromDate,
      hasToDate: hasToDate ?? this.hasToDate,
      hasDocumentDate: hasDocumentDate ?? this.hasDocumentDate,
      hasStartMeter: hasStartMeter ?? this.hasStartMeter,
      hasEndMeter: hasEndMeter ?? this.hasEndMeter,
      hasClass: hasClass ?? this.hasClass,
      noOfDays: noOfDays ?? this.noOfDays,
      imageUrl: imageUrl ?? this.imageUrl,
      classes: classes ?? this.classes,
      items: items ?? this.items,
    );
  }
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
        : json['grade_type'] != null
            ? Policy.fromJson(json)
            : null;
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

    return other is CategoryClass && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Policy {
  int? id;
  int? gradeId;
  String? gradeType;
  String? gradeClass;
  double? gradeAmount;
  String? approver;
  String? status;

  Policy({
    this.id,
    this.gradeId,
    this.gradeType,
    this.gradeClass,
    this.gradeAmount,
    this.approver,
    this.status,
  });

  Policy.fromJson(Map<String, dynamic> json) {
    id = json['policy_id'];
    gradeId = json['grade_id'];
    gradeType = json['grade_type'];
    gradeClass = json['grade_class'];
    gradeAmount = json['grade_amount'] != null
        ? double.tryParse(json['grade_amount'].toString())
        : null;
    approver = json['approver'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'policy_id': id,
      'grade_id': gradeId,
      'grade_type': gradeType,
      'grade_class': gradeClass,
      'grade_amount': gradeAmount,
      'approver': approver,
      'status': status,
    };
  }
}

