import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final String baseUrl = "http://localhost/healthlog";

  togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;

    try {
      print("Attempting login for: $email");

      final response = await http.post(
        Uri.parse("$baseUrl/login.php"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {"email": email, "password": password},
      );

      print("Status code: ${response.statusCode}");
      print("Response: ${response.body}");

      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      print("Login error: $e");
      isLoading.value = false;
      return false;
    }
  }
}
