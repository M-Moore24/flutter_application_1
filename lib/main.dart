import 'package:flutter/material.dart';
import 'package:flutter_application_1/user_creation_form.dart';
import 'package:flutter_application_1/user_signin_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserSignInForm(),
    );
    
  }
}