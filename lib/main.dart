import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/routes.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  Get.put(LoginController());
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}
