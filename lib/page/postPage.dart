
import 'dart:ui';

class EmpResponse {

  String? status;
  List<Post>? data;
  String? message;
  EmpResponse({this.status, this.data, this.message});
  factory EmpResponse.fromJson(Map<String, dynamic> json) => EmpResponse (
    status: json['status'],
    data: json['data'] != null ? List<Post>.from(json["data"].map((x) => Post.fromJson(x))) : null,
    message: json['message'],
  );

  Map<String , dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toString())),
    "message": message,


  };
}

class Post {
  int? id;
  String? employee_name;
  String? employee_salary;
  int? employee_age;
  String? profile_image;

  Post({
     this.id,
    this.employee_name,
     this.employee_salary,
    this.employee_age,
    this.profile_image,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        employee_name = json['employee_name'],
        employee_salary = json['employee_salary'],
        employee_age = json['employee_age'],
        profile_image = json['profile_image'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'employee_name': employee_name,
    'employee_salary': employee_salary,
    'employee_age': employee_age,
    'profile_image': profile_image,
  };
}
