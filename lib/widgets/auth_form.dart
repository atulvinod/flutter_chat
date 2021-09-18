import 'dart:io';

import 'package:firebasetut/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  final Function(BuildContext, String, String, String, bool, File?)
      submitCallback;
  const AuthFormWidget(this.submitCallback, {Key? key}) : super(key: key);

  @override
  _AuthFormWidgetState createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _userEmail = '';
  String? _userName = '';
  String? _password = '';
  File? _userImage;
  bool _isLogin = true;

  _trySubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please select image')));
    }
    //To close the Soft Keyboard
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    widget.submitCallback(context, _userName!.trim(), _userEmail!.trim(),
        _password!.trim(), _isLogin, _userImage);
  }

  _pickedImage(File? file) {
    _userImage = file;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    //To uniquely identify the formfield to correct error when the
                    // other form field is removed or added to the Form Widget
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(labelText: 'UserName'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    //To hide the input when entering password
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter password';
                      }
                      if ((value?.length ?? 0) < 7) {
                        return 'Password cannot be less than 7 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create New Account'
                        : 'I already have an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
