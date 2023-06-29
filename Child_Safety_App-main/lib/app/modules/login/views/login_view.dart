import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(
          children: [
            Text(
              'LoginView is working',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton( onPressed: () {
              Get.toNamed(Routes.STATISTICS);
            },
                child:Text("View Stats"))
          ],
        ),
      ),
    );
  }
}
