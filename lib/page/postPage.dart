import 'dart:ui';

class Post {
  int? id;
  String? firstName;
  String? lastName;
  String? contact;
  String? date;

  Post({
    this.id,
    this.firstName,
    this.lastName,
    this.contact,
    this.date,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        contact = json['contact'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'contact': contact,
    'date': date,
  };
}
