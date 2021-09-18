import 'package:firebasetut/screens/auth_screen.dart';
import 'package:firebasetut/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Implement the Android configuration in build.gradle files to implement Firebase

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Messaging ',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        accentColorBrightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),
      home: StreamBuilder(
          // We listen to the authentication state of the user using streams
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            // We check if the userSnapshot has some data, this will happend
            // when the user is authenticated
            if (userSnapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          }),
    );
  }
}
