class EmployeeResponse {
  late bool success;
  late String message;
  late List<Employee> employee;

  EmployeeResponse({this.success = false, this.message = '', this.employee = const []});

  EmployeeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;
    employee = <Employee>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        employee.add(Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = message;
    data['data'] = employee.map((v) => v.toJson()).toList();
    return data;
  }
}

class Employee {
  int? id;
  int? grade;
  String? name;
  String? employeeId;
  String? category;
  String? empBranch;
  String? empBaseLocation;
  bool? isDuplication;
  String? duplicationId;
  String? documentDate;
  int? categoryId;

  Employee({
    this.id,
    this.grade,
    this.name,
    this.employeeId,
    this.empBranch,
    this.empBaseLocation,
    this.isDuplication,
    this.duplicationId,
    this.category,
    this.documentDate,
    this.categoryId,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['emp_id'];
    name = json['emp_name'];
    grade = json['grade'] ?? json['emp_grade'];
    empBranch = json['emp_branch'];
    empBaseLocation = json['emp_baselocation'];
    isDuplication = json['is_duplication'];
    duplicationId = json['duplication_claim_id'];
    category = json['category'];
    categoryId = json['category_id'];
    documentDate = json['document_date'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emp_id': employeeId,
      'emp_name': name,
      'grade': grade,
      'emp_branch': empBranch,
      'emp_baselocation': empBaseLocation,
      'is_duplication': isDuplication,
      'duplication_claim_id': duplicationId,
      'category': category,
      'document_date': documentDate,
      'category_id': categoryId,
    };
  }
}
