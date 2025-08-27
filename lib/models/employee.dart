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
  late int id;
  late int grade;
  late String name;
  late String employeeId;
   String? category;
  late String empBranch;
  late String empBaseLocation;
    bool? isDuplication;
    String? duplicationId;
    String? documentDate;
    int? categoryId;
    

  Employee( {this.id = 0,this.grade = 0,this.name = '',this.employeeId = '',this.empBranch = '',this.empBaseLocation = '',this.isDuplication,this.duplicationId,this.category= '',this.documentDate,this.categoryId});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['emp_id'];
    name = json['emp_name'] ?? '';
    grade = json['grade'] ?? (json['emp_grade'] ?? 0);
    empBranch = json['emp_branch'] ?? '';
    empBaseLocation = json['emp_baselocation'] ?? '';
    isDuplication=json['is_duplication']??false;
    duplicationId=json['duplication_claim_id'];
    category:json['category'];
    categoryId:json['category_id'];
    documentDate:json['document_date'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_id'] = this.employeeId;
    data['emp_name'] = this.name;
    data['grade'] = this.grade;
    data['emp_branch'] = this.empBranch;
    data['emp_baselocation'] = this.empBaseLocation;
    data['is_duplication'] = this.isDuplication;
    data['duplication_claim_id'] = this.duplicationId;
    data['category'] = this.category;
    data['document_date'] = this.documentDate;
    data['document_date'] = this.categoryId;

    return data;
  }
}
