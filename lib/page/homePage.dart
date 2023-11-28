import 'package:firebase_1_setting/service/realTimeDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'CreatePage.dart';
import 'PostPage.dart';
import '../service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  Future _callCreatePage() async {
    Map results = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
      return CreatePage();
    }));

    if (results != null && results.containsKey("data")) {
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
        title: Text("FireBase"),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: Icon(Icons.exit_to_app),
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
          isLoading ? const Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          _callCreatePage();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  post.employee_name!,
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
                Text(
                  post.employee_age.toString(),
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
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
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Delete",
          ),
        ],
      ),
    );
  }
}
