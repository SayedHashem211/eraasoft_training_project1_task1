class AddNewDepartmentModel {
  String? message;
  List<dynamic>? data;
  bool? status;
  int? code;

  AddNewDepartmentModel({this.message, this.data, this.status, this.code});

  AddNewDepartmentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}