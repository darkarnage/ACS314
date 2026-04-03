import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  final String baseUrl = "http://localhost/healthlog";

  String? validateFullName(String value) {
    if (value.isEmpty) return "Full name is required";
    if (value.length < 3) return "Name must be at least 3 characters";
    // Only letters and spaces allowed
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return "Name can only contain letters and spaces";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 8) return "Password must be at least 8 characters";
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number";
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) return "Please confirm your password";
    if (value != passwordController.text) return "Passwords do not match";
    return null;
  }

  String? fullNameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  Future<void> registerUser() async {
    // Run all validations
    setState(() {
      fullNameError = validateFullName(fullNameController.text.trim());
      emailError = validateEmail(emailController.text.trim());
      passwordError = validatePassword(passwordController.text);
      confirmPasswordError = validateConfirmPassword(
        confirmPasswordController.text,
      );
    });

    // Stop if any error exists
    if (fullNameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register.php"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "full_name": fullNameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text,
        },
      );

      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        Get.snackbar(
          "Success",
          "Account created successfully",
          backgroundColor: Colors.green[100],
        );
        Get.offAndToNamed("/");
      } else {
        Get.snackbar(
          "Error",
          data['message'],
          backgroundColor: Colors.red[100],
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not connect to server",
        backgroundColor: Colors.red[100],
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.water_drop, color: Colors.blue, size: 28),
                  SizedBox(width: 8),
                  Text(
                    "HealthLog",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              const Center(
                child: Text(
                  "Begin Your Journey",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Create your personal sanctuary for health tracking.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                ),
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "FULL NAME",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 1.1,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: fullNameController,
                      onChanged: (_) {
                        if (fullNameError != null) {
                          setState(() => fullNameError = null);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "John Doe",
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                        errorText: fullNameError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "EMAIL ADDRESS",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 1.1,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      onChanged: (_) {
                        if (emailError != null) {
                          setState(() => emailError = null);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "name@example.com",
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        errorText: emailError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 1.1,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      onChanged: (_) {
                        if (passwordError != null) {
                          setState(() => passwordError = null);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Pin or Password",
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        errorText: passwordError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "CONFIRM PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 1.1,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      onChanged: (_) {
                        if (confirmPasswordError != null) {
                          setState(() => confirmPasswordError = null);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Pin or Password",
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.verified_user_outlined,
                          color: Colors.grey,
                        ),
                        errorText: confirmPasswordError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: isLoading ? null : registerUser,
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : const Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Center(
                child: Text(
                  "BY CONTINUING, YOU AGREE TO THE HEALTHLOG",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 10,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TERMS OF SERVICE",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10,
                      decoration: TextDecoration.underline,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    "  &  ",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 10),
                  ),
                  Text(
                    "PRIVACY POLICY",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10,
                      decoration: TextDecoration.underline,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
