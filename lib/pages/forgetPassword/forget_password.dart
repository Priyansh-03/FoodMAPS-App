import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/widgets/my_button.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Forget Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "Email"),
                onChanged: (value) {
                  setState(
                    () {
                      email = value.trim();
                      value.trim();
                    },
                  );
                }),
            SizedBox(
              height: 20,
            ),
            MyButton(
              onPressed: (() async {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email!)
                    .whenComplete(
                      () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("An Email has been send $email to Verify,"),
                        ),
                      ),
                    );
                Navigator.pop(context);
              }),
              text: "Send Request",
            ),
          ],
        ),
      ),
    );
  }
}
