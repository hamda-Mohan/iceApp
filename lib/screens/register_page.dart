import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController =
        Get.find<AuthController>(); // Ensure GetX Controller is found

    return Scaffold(
      backgroundColor: const Color(0xFFB0E5FE),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      authController.register(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    } else {
                      Get.snackbar(
                        "Error",
                        "Passwords do not match",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.to(() => LoginPage());
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
