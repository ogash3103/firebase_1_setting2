import 'package:firebase_1_setting/service/realTimeDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'CreatePage.dart';
import '../service/auth_service.dart';
import 'postPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, Key});
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  Future _callCreatePage() async {
    Map results = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const CreatePage();
    }));

    if (results.containsKey("data")) {
      print(results['data']);
      _apiPostList();
    }
  }
  _apiPostList() async{
    setState(() {
      isLoading= true;
    });

    var list = await RTDBService.getPosts();
    items.clear();
    setState(() {
      items = list.cast<Post>();
      isLoading= false;
    });
  }
  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FireBase"),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(items[index]);
            },
          ),
          isLoading ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          _callCreatePage();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Update",
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              child: post.img_url != null ? Image.network(post.img_url!, fit: BoxFit.cover,) : Image.asset("assets/images/user.jpg"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const SizedBox(height: 10,),
                Text(
                  'First Name: ${post.firstName}',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Last Name: ${post.lastName}',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Contact: ${post.contact}',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Data: ${post.date}',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}