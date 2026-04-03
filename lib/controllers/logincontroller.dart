import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  var loggedInUserId = ''.obs;
  var loggedInName = ''.obs;
  var loggedInEmail = ''.obs;

  final String baseUrl = "http://localhost/healthlog";

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void logout() {
    loggedInUserId.value = '';
    loggedInName.value = '';
    loggedInEmail.value = '';
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
        loggedInUserId.value = data['user_id'].toString();
        loggedInName.value = data['full_name'];
        loggedInEmail.value = data['email'];

        print(
          "Logged in as: ${loggedInName.value} (ID: ${loggedInUserId.value})",
        );

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
