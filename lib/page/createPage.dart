
import 'package:flutter/material.dart';
import '../service/realTimeDatabase.dart';
import 'postPage.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var contactController = TextEditingController();
  var dateController = TextEditingController();
  var isLoading = false;

  _createPost() {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String contact = contactController.text.toString();
    String date = dateController.text.toString();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        contact.isEmpty ||
        date.isEmpty) {
      return;
    }

    _apiCreatePost(firstName, lastName, contact, date);
  }

  _apiCreatePost( String firstName,
      String lastName, String contact, String date) {
    setState(() {
      isLoading = true;
    });

    var g = Post(
      id: 1,
      firstName: firstName,
      lastName: lastName,
      contact: contact,
      date: date,
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
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: contactController,
                  decoration: InputDecoration(
                    hintText: "Contact",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    hintText: "Date",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    _createPost();
                  },
                  color: Colors.blue,
                  child: Text("Create",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
