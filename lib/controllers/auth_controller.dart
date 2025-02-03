// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:ice_cream_app/screens/menu_page.dart';
// import '../screens/login.dart';
// import 'package:ice_cream_app/screens/Home.dart'; // Ensure this file exists or replace with the correct page

// class AuthController extends GetxController {
//   static AuthController instance = Get.find();
//   late Rx<User?> _user;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   FirebaseFirestore firestore =
//       FirebaseFirestore.instance; // Firestore instance

//   @override
//   void onReady() {
//     super.onReady();
//     _user = Rx<User?>(auth.currentUser);
//     _user.bindStream(auth.userChanges());
//     ever(_user, _initialScreen);
//   }

//   void _initialScreen(User? user) {
//     if (user == null) {
//       Get.offAll(() => HomePage()); // Navigate to login if no user is logged in
//     } else {
//       Get.offAll(() => LoginPage()); // Replace with actual home screen
//     }
//   }

//   Future<void> register(String name, String email, String password) async {
//     try {
//       UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Save user details to Firestore
//       await firestore.collection('users').doc(userCredential.user!.uid).set({
//         'name': name,
//         'email': email,
//         'uid': userCredential.user!.uid,
//       });

//       Get.snackbar("Success", "Account created successfully",
//           backgroundColor: Colors.green, colorText: Colors.white);
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

//   Future<void> login(String email, String password) async {
//     try {
//       await auth.signInWithEmailAndPassword(email: email, password: password);
//       Get.to(() => Homepage());
//       Get.snackbar("Success", "Logged in successfully",
//           backgroundColor: Colors.green, colorText: Colors.white);
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

//   Future<void> logout() async {
//     await auth.signOut();
//     update(); // Ensure state update after logout
//     Get.offAll(() => LoginPage()); // Redirect to login page after logout
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ice_cream_app/screens/menu_page.dart';
import '../screens/login.dart';
import '../screens/Home.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userName = ''.obs; // Store user name

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);

    if (_user.value != null) {
      fetchUserData(); // Fetch data if user is logged in
    }
  }

  void _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      fetchUserData(); // Fetch user data
      Get.offAll(() => HomePage());
    }
  }

  void fetchUserData() async {
    if (auth.currentUser != null) {
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      userName.value = userDoc['name'] ?? 'Unknown User'; // Update name
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user details to Firestore
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'uid': userCredential.user!.uid,
      });

      userName.value = name; // Update userName
      Get.snackbar("Success", "Account created successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      fetchUserData(); // Fetch user name after login
      Get.offAll(() => Homepage());
      Get.snackbar("Success", "Logged in successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    userName.value = ''; // Clear user name
    Get.offAll(() => LoginPage());
  }
}
