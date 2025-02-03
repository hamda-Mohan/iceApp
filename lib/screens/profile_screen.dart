// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:ice_cream_app/screens/thank.dart';

// // class ProfilePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: Colors.black),
// //           onPressed: () => Get.back(),
// //         ),
// //         title: Text("My Profile", style: TextStyle(color: Colors.blueAccent)),
// //         centerTitle: true,
// //       ),
// //       body: Column(
// //         children: [
// //           SizedBox(height: 20),
// //           Center(
// //             child: CircleAvatar(
// //               radius: 50,
// //               backgroundColor: Colors.grey.shade300,
// //               backgroundImage:
// //                   AssetImage('assets/profile.png'), // Add your own image
// //             ),
// //           ),
// //           SizedBox(height: 20),
// //           _profileOption(
// //               title: "My Orders",
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => ThankYouPage()));
// //               }),
// //           _profileOption(title: "My Favorites", onTap: () {}),
// //           _profileOption(
// //               title: "Log Out",
// //               onTap: () {
// //                 // Logout function
// //               }),
// //         ],
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         selectedItemColor: Colors.pinkAccent,
// //         unselectedItemColor: Colors.black54,
// //         items: [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Menu"),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.favorite_border), label: "Favorite"),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.shopping_cart), label: "Cart"),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.person, color: Colors.pinkAccent),
// //               label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _profileOption({required String title, required VoidCallback onTap}) {
// //     return ListTile(
// //       title: Text(title, style: TextStyle(fontSize: 18)),
// //       trailing: Icon(Icons.arrow_forward_ios, size: 16),
// //       onTap: onTap,
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../controllers/auth_controller.dart'; // Ensure this controller exists

// class ProfilePage extends StatelessWidget {
//   final AuthController authController = Get.find(); // GetX AuthController

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         title: Text("My Profile", style: TextStyle(color: Colors.blueAccent)),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Center(
//             child: CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.grey.shade300,
//               backgroundImage: AssetImage('assets/profile.png'),
//             ),
//           ),
//           SizedBox(height: 20),

//           // Fetch and Display User Name
//           FutureBuilder<DocumentSnapshot>(
//             future: FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                 .get(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator(); // Loading indicator
//               }
//               if (!snapshot.hasData || !snapshot.data!.exists) {
//                 return Text("User not found",
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
//               }
//               var userData = snapshot.data!.data() as Map<String, dynamic>;
//               return Text(
//                 " ${userData['name']}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               );
//             },
//           ),

//           SizedBox(height: 20),
//           _profileOption(title: "My Orders", onTap: () {}),
//           _profileOption(title: "My Favorites", onTap: () {}),
//           _profileOption(
//             title: "Log Out",
//             onTap: () {
//               authController
//                   .logout(); // Call the logout function from AuthController
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _profileOption({required String title, required VoidCallback onTap}) {
//     return ListTile(
//       title: Text(title, style: TextStyle(fontSize: 18)),
//       trailing: Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: onTap,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.find(); // Get the controller

  @override
  Widget build(BuildContext context) {
    // Fetch user data when ProfilePage opens
    authController.fetchUserData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text("My Profile", style: TextStyle(color: Colors.blueAccent)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Center(
          //   child: CircleAvatar(
          //     radius: 50,
          //     backgroundColor: Colors.grey.shade300,
          //     backgroundImage: AssetImage('assets/profile.png'),
          //   ),
          // ),
          SizedBox(height: 20),

          // Display Username Instantly
          Obx(() => Text(
                "Welcome, ${authController.userName.value.isNotEmpty ? authController.userName.value : 'Guest'}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),

          SizedBox(height: 20),
          // _profileOption(title: "My Orders", onTap: () {}),
          // _profileOption(title: "My Favorites", onTap: () {}),
          _profileOption(
            title: "Log Out",
            onTap: () {
              authController.logout();
            },
          ),
        ],
      ),
    );
  }

  Widget _profileOption({required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 18)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
