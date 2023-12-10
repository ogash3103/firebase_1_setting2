
class Post {
  int? id;
  String? firstName;
  String? lastName;
  String? contact;
  String? date;
  String? img_url;

  Post({
    this.id,
    this.firstName,
    this.lastName,
    this.contact,
    this.date,
   this.img_url
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        contact = json['contact'],
        date = json['date'],
       img_url = json['img_url'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'contact': contact,
    'date': date,
    'img_url': img_url,
  };
}
