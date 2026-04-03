import 'package:flutter_application_1/views/categoryscreen.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/listscreen.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/homescreen.dart';
import 'package:flutter_application_1/views/signup.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(name: "/", page: () => LoginScreen()),
  GetPage(name: "/signup", page: () => SignupScreen()),
  GetPage(name: "/homescreen", page: () => Homescreen()),
  GetPage(name: "/dashboard", page: () => DashboardScreen()),
  GetPage(name: "/category", page: () => Categoryscreen()),
  GetPage(name: "/list", page: () => ListScreen()),
];
