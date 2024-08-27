
import 'package:travel_claim/models/branch.dart';

class UserResponse {
  late bool success;
  User? user;

  UserResponse({this.success = false, this.user,});

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['statusCode'] == 200;
    if(json['data']!=null) {
      user = User.fromJson(json['data']);
    }
  }
}

class User {
  late String employeeId;
  late int id;
  late String profilePhoto;
  late String name;
  late String phoneNumber;
  late String email;
  late String userName;
  late String department;
  late String location;
  late String designation;
  late int grade;
  late String reportingPerson;
  late String reportingPersonEmpid;
  late String role;
  Branch? branch;
  Branch? baseLocation;


  User(
      {this.employeeId = '',
        this.id = 0,
        this.profilePhoto = '',
        this.name = '',
        this.phoneNumber = '',
        this.email = '',
        this.userName = '',
        this.department = '',
        this.location = '',
        this.designation = '',
        this.grade = -1,
        this.reportingPerson = '',
        this.reportingPersonEmpid = '',
        this.branch,
        this.baseLocation,
        this.role = ''});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['emp_id'] ?? '';
    profilePhoto = json['profile_photo'] ?? '';
    name = json['emp_name'] ?? '';
    userName = json['user_name'] ?? '';
    email = json['email'] ?? '';
    phoneNumber = json['emp_phonenumber'] ?? '';
    department = json['emp_department'] ?? '';
    location = (json['emp_baselocation'] ?? '').toString();
    designation = json['emp_designation'] ?? '';
    grade = json['emp_grade'] ?? -1;
    reportingPerson = json['reporting_person'] ?? '';
    reportingPersonEmpid = json['reporting_person_empid'] ?? '';
    role = json['emp_role'] ?? '';
    if(json['branch_details']!=null){
      branch = Branch.fromJson(json['branch_details']);
    }
    if(json['baselocation_details']!=null){
      baseLocation = Branch.fromJson(json['baselocation_details']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.employeeId;
    data['id'] = this.id;
    data['profile_photo'] = this.profilePhoto;
    data['emp_name'] = this.name;
    data['emp_phonenumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['user_name'] = this.userName;
    data['emp_department'] = this.department;
    data['emp_branch'] = this.branch;
    data['emp_baselocation'] = this.location;
    data['emp_designation'] = this.designation;
    data['emp_grade'] = this.grade;
    data['reporting_person'] = this.reportingPerson;
    data['reporting_person_empid'] = this.reportingPersonEmpid;
    data['emp_role'] = this.role;
    return data;
  }
}
