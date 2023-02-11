import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/home/home_page.dart';

import '../../../route/routing_page.dart';

class LoginAuthProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(LoginAuthProvider.pattern.toString());

  bool loading = false;

  UserCredential? userCredential;

  void loginPageValidation(
      {required TextEditingController? emailAdress,
      required TextEditingController? password,
      required BuildContext context}) async {
    if (emailAdress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email Address is empty"),
        ),
      );
      return;
    } else if (!regExp.hasMatch(emailAdress.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Email Address"),
        ),
      );
      return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is Empty"),
        ),
      );
      return;
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password must be of atleast 8 characters"),
        ),
      );
      return;
    } else {
      try {
        loading = true;
        notifyListeners();

        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailAdress.text,
          password: password.text,
        )
            .then(
          (value) async {
            loading = false;
            notifyListeners();
            RoutingPage.goTonext(
              context: context,
              navigateTo: HomePage(),
            );
          },
        );
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == "user-not-found") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("ERROR: User not found"),
            ),
          );
        } else if (e.code == "wrong-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("ERROR: Wrong Password"),
            ),
          );
        }
      }
    }
  }
}
