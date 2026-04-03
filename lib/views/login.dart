import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get.dart';

final LoginController loginController = Get.find<LoginController>();
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Shield icon
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.health_and_safety,
                          color: Colors.blue,
                          size: 34,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Welcome text
                      const Text(
                        "Welcome back",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Continue your wellness journey with HealthLog.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                      ),
                      const SizedBox(height: 28),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "EMAIL ADDRESS",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            letterSpacing: 1.1,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "name@example.com",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "PASSWORD",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              letterSpacing: 1.1,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Obx(
                        () => TextField(
                          obscureText: !loginController.isPasswordVisible.value,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Pin or Password",
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.grey,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => loginController.togglePassword(),
                              child: Icon(
                                loginController.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Obx(
                        () => GestureDetector(
                          onTap: loginController.isLoading.value
                              ? null
                              : () async {
                                  if (usernameController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    Get.snackbar(
                                      "Error",
                                      "Please enter both email and password",
                                      backgroundColor: Colors.red[100],
                                    );
                                    return;
                                  }
                                  bool success = await loginController.login(
                                    usernameController.text,
                                    passwordController.text,
                                  );

                                  if (success) {
                                    Get.offAndToNamed("/homescreen");
                                  } else {
                                    Get.snackbar(
                                      "Login Failed",
                                      "Invalid email or password",
                                      backgroundColor: Colors.red[100],
                                    );
                                  }
                                },
                          child: Container(
                            width: double.infinity,
                            height: 52,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: loginController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.blue,
                                  )
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.black54),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed("/signup"),
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: Colors.blueGrey,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "SECURE ENCRYPTION",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.info_outline, color: Colors.blueGrey, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "PRIVACY FIRST",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
