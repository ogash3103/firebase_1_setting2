import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../page/postPage.dart';

class RTDBService {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<void> addPost(Post post) async {
    await _database.child("posts").push().set(post.toJson());
  }

  static Future<List<Post>> getPosts() async {
    List<Post> items = [];
    Query _query = _database.ref.child("posts");
    DatabaseEvent event = await _query.once();
    var snapshot = event.snapshot;
    for (var child in snapshot.children) {
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
        employee_name: map['employee_name'],
        employee_salary: map['employee_salary'],
        id: map['id'],
      );
      items.add(post);
    }
    return items;
  }

}
