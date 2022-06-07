import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStudentPage extends StatefulWidget {
  const UpdateStudentPage({Key? key}) : super(key: key);

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var id = Get.arguments[0]['id'];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Student"),
        ),
        body: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future:
                FirebaseFirestore.instance.collection('students').doc(id).get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print("Snapshot Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var email = data['email'];
              var password = data['password'];

              print(id);
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(children: [
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
                        onChanged: (value) => name = value,
                        initialValue: name,
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
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            errorStyle: const TextStyle(color: Colors.amber)),
                        onChanged: (value) => email = value,
                        initialValue: email,
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
                            labelText: password,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            errorStyle: const TextStyle(color: Colors.amber)),
                        onChanged: (value) => password = value,
                        initialValue: "******",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }

                          return null;
                        },
                        obscureText: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                updateUser(id, name, email, password);
                              }
                            },
                            child: const Text("Update")),
                        ElevatedButton(
                            onPressed: () {}, child: const Text("Reset")),
                      ],
                    ),
                  ]));
            },
          ),
        ));
  }
}

CollectionReference student = FirebaseFirestore.instance.collection('students');

Future updateUser(id, name, email, password) async {
  return student
      .doc(id)
      .update({'name': name, 'email': email, 'password': password})
      .then((value) => Get.snackbar("", "Data Updated",
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green))
      .catchError((error) => Get.snackbar("Failed", "$error"));
}
