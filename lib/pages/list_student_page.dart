import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'update_student.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> StudentsStream =
      FirebaseFirestore.instance.collection("students").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: StudentsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print("Snapshot Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final List Storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot doc) {
          Map m = doc.data() as Map<String, dynamic>;
          Storedocs.add(m);

          //add id in  list for updating and deleting data
          m["id"] = doc.id;
        }).toList();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140)
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text("Name"),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text("Email"),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text("Action"),
                      ),
                    )),
                  ]),
                  for (var i = 0; i < Storedocs.length; i++) ...[
                    TableRow(children: [
                      TableCell(
                          child: Container(
                        child: Center(
                          child: Text(Storedocs[i]['name']),
                        ),
                      )),
                      TableCell(
                          child: Container(
                        child: Center(
                          child: Text(Storedocs[i]['email']),
                        ),
                      )),
                      TableCell(
                          child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.to(() => const UpdateStudentPage(),
                                    arguments: [
                                      {
                                        'id': Storedocs[i]['id'],
                                      }
                                    ]);
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 14,
                                color: Colors.amber,
                              )),
                          IconButton(
                              onPressed: () {
                                deleteUser(Storedocs[i]["id"]);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 14,
                                color: Colors.red,
                              ))
                        ],
                      )),
                    ]),
                  ],
                ]),
          ),
        );
      },
    );
  }

//for deleting user we have to make instance
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future deleteUser(id) async {
    // print("User deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => Get.snackbar("", "Deleted",
            snackStyle: SnackStyle.FLOATING,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green))
        .catchError((error) => Get.snackbar("Failed", "$error"));
  }
}
