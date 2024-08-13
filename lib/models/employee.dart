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

  Employee({this.id = 0,this.grade = 0,this.name = '',this.employeeId = ''});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['emp_id'];
    name = json['emp_name'] ?? '';
    grade = json['grade'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_id'] = this.employeeId;
    data['emp_name'] = this.name;
    data['grade'] = this.grade;
    return data;
  }
}
