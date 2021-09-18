import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetut/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //TODO: Enable Email/Password authentication from Firebase Console > Authentication
  final _auth = FirebaseAuth.instance;

  // We also send the Buildcontext to prevent context error when using the snackbar
  _submitAuthForm(BuildContext ctx, String username, String email,
      String password, bool isLogin) async {
// We will use the firebase auth pacakage to manage the login and signup for users

    UserCredential authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // We save the username to the firestore under users collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({'username': username, 'email': email});
      }

      // TO catch firebase errors related to signin
    } on PlatformException catch (err) {
      var message =
          err.message ?? "An error occured, please check your credentials";
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Authenticate'),
        ),
        body: AuthFormWidget(_submitAuthForm));
  }
}
