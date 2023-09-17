class UpdateDepartmentModel {
  String? message;
  Data? data;
  bool? status;
  int? code;

  UpdateDepartmentModel({this.message, this.data, this.status, this.code});

  UpdateDepartmentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  List<String>? managerId;

  Data({this.managerId});

  Data.fromJson(Map<String, dynamic> json) {
    managerId = json['manager_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manager_id'] = this.managerId;
    return data;
  }
}