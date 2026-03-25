import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final String baseUrl = "http://localhost/Healthlog";

  togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login.php"),
        body: {"email": email, "password": password},
      );

      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        // Save user details so other screens can use them
        Get.put(
          UserSession()
            ..userId = data['user_id'].toString()
            ..fullName = data['full_name']
            ..email = data['email'],
        );

        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }
}

// Stores logged in user details for use across the app
class UserSession extends GetxController {
  String userId = '';
  String fullName = '';
  String email = '';
}
