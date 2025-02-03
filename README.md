# ice_cream_app

A new Flutter project.


## Melty Magic - Ice Cream App

Welcome to Melty Magic, a beautifully designed Flutter application for ordering ice cream online. This app allows users to browse ice cream flavors, add them to their cart, and place orders seamlessly.

🚀 Features
Getting Started
User Authentication: Login and Register using Firebase Authentication

Smooth UI: Clean and interactive design with a user-friendly experience

Favorites List: Save favorite ice cream flavors

Shopping Cart: Add and manage ice cream orders

Secure Payments: Checkout process for placing orders

Profile Management: Users can view orders and manage their account

📸 Screenshots





🛠 Tech Stack

Flutter - Frontend development

Firebase Authentication - Secure user login

GetX - State management

Cloud Firestore - Database for storing ice cream data

📖 Installation

Clone the repository:

Navigate to the project directory:

cd melty-magic

Install dependencies:

flutter pub get

Run the app:

flutter run

🔥 Firebase Setup

Create a Firebase project at Firebase Console

Add an Android & iOS app inside Firebase

Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) and place them inside the project:

android/app/google-services.json

ios/Runner/GoogleService-Info.plist

Enable Authentication (Email/Password Sign-in) in Firebase Console

Set up Cloud Firestore to store user and product data

🧑‍💻 State Management with GetX

The app uses GetX for efficient state management. Example of navigation:

Get.to(() => CartPage());

🤝 Contributing

Fork the project

Create a feature branch (git checkout -b feature-branch)

Commit your changes (git commit -m 'Add new feature')

Push to your branch (git push origin feature-branch)

Open a Pull Request

