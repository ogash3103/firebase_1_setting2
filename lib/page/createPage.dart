
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../service/Storege_service.dart';
import '../service/realTimeDatabase.dart';
import 'postPage.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key, Key});

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

  File? _image;
  final picker = ImagePicker();

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
    if(_image == null)return;

    _apiUploadImage(firstName, lastName, date, contact, _image!.path);
  }

  _apiUploadImage( String firstName, String lastName, String date, String contact, String img_url) {
    setState(() {
      isLoading = true;
    });

    SotreSevice.uploadImage(_image!).then((value) => {
      _apiCreatePost(firstName, lastName, date, contact, img_url)
    });
  }

  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': "done"});
  }

  _apiCreatePost(String firstName , String lastName , String date , String contact, String img_url){
    var post = Post(
      id: 1,
      firstName: firstName,
      lastName: lastName,
      contact: contact,
      date: date,
      img_url: img_url,
    );
    RTDBService.addPost(post).then((value) => {_resAddPost()});
  }

  Future _getImage() async {
    final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a post"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              GestureDetector(
                onTap: _getImage,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: _image != null  ? Image.file(_image! , fit: BoxFit.cover) : Image.asset("assets/images/user.jpg"),
                ),
              ),
                const SizedBox(height: 15,),

                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    hintText: "First Name",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: contactController,
                  decoration: const InputDecoration(
                    hintText: "Contact",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    hintText: "Date",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    _createPost();
                  },
                  color: Colors.blue,
                  child: const Text("Create",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
