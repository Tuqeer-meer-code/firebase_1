import 'package:firebase_1/pages/list_student_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_student_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Flutter FireStore"),
          ElevatedButton(
              onPressed: () {
                Get.to(() => const AddStudentPage());
              },
              child: const Text("Add"))
        ]),
      ),
      body: const ListStudentPage(),
    );
  }
}
