// rtdb_service.dart

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
    Query query = _database.ref.child("posts");
    DatabaseEvent event = await query.once();
    var snapshot = event.snapshot;
    for (var child in snapshot.children) {
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
        firstName: map['firstName'],
        lastName: map['lastName'],
        contact: map['contact'],
        date: map['date'],
        img_url: map['img_url'],
      );
      items.add(post);
    }
    return items;
  }
}
