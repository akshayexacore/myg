class BranchResponse {
  late bool success;
  late String message;
  late List<Branch> branches;

  BranchResponse({this.success = false, this.message = '', this.branches = const []});

  BranchResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;
    branches = <Branch>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        branches.add(Branch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = message;
    data['data'] = branches.map((v) => v.toJson()).toList();
    return data;
  }
}

class Branch {
  late int id;
  late String name;
  late String code;

  Branch({this.id = 0,this.name = '',this.code = ''});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['branch_id'];
    name = json['branch_name'] ?? '';
    code = json['branch_code'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.id;
    data['branch_name'] = this.name;
    data['branch_code'] = this.code;
    return data;
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Branch &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

}
