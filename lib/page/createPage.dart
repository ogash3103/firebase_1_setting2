import 'package:firebase_1_setting/page/postPage.dart';
import 'package:flutter/material.dart';
import '../service/realTimeDatabase.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var isLoading = false;

  _createPost() {
    String employee_name = titleController.text.toString();
    String employee_age = contentController.text.toString();

    if (employee_name.isEmpty || employee_age.isEmpty) return;

    _apiCreatePost(employee_name, employee_age);
  }

  _apiCreatePost(String employee_name, String employee_age) {
    setState(() {
      isLoading = true;
    });

    var g = Post(
      id: 1,
      employee_name: employee_name,
      employee_salary: employee_age,
    );

    RTDBService.addPost(g).then((value) {
      _resAddPost();
    });
  }

  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': "done"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a post"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: "Age",
                  ),
                ),
                SizedBox(height: 10,),
                MaterialButton(
                  onPressed: () {
                    _createPost();
                  },
                  color: Colors.blue,
                  child: Text("Create", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            isLoading ? const Center(child: CircularProgressIndicator(),) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
