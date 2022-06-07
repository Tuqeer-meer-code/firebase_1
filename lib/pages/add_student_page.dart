import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var email = "";
  var password = "";
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorStyle: const TextStyle(color: Colors.amber)),
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: "Emai",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorStyle: const TextStyle(color: Colors.amber)),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorStyle: const TextStyle(color: Colors.amber)),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter password';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            name = nameController.text;
                            password = passwordController.text;
                            email = emailController.text;
                            addUser();
                            clearText();
                          }
                        },
                        child: const Text("Add")),
                    ElevatedButton(
                        onPressed: () {
                          clearText();
                        },
                        child: const Text("Reset")),
                  ],
                )
              ],
            ),
          )),
    );
  }

  clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

//adding user to firebase
  CollectionReference student =
      FirebaseFirestore.instance.collection('students');
  Future addUser() async {
    return student
        .add({'name': name, 'email': email, 'password': password})
        .then((value) => Get.snackbar("Added", "Student added",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green))
        .catchError((error) => Get.snackbar("Added", "Student added",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green));
  }
}
