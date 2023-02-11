import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/SignUp/component/signup_auth_provider.dart';
import 'package:foodmaps_flutter/pages/login/login_page.dart';
import 'package:provider/provider.dart';

import '../../route/routing_page.dart';
import '../../widgets/my_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAdress = TextEditingController();
  TextEditingController password = TextEditingController();

  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    SignupAuthProvider signupAuthProvider =
        Provider.of<SignupAuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Welcome to FoodMAPS\n\t\t\t\t\t\t\t\t\t\t\t\t\tSign Up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: fullName,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                    ),
                  ),
                  TextFormField(
                    controller: emailAdress,
                    decoration: InputDecoration(
                      hintText: "Email Adress",
                    ),
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: visibility,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        icon: Icon(
                          visibility
                              ? Icons.visibility_off
                              : Icons.visibility_rounded,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  signupAuthProvider.loading == false
                      ? MyButton(
                          onPressed: () {
                            signupAuthProvider.signupValidation(
                              fullName: fullName,
                              context: context,
                              emailAdress: emailAdress,
                              password: password,
                            );
                          },
                          text: "SIGN UP",
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already Have An Account?\t\t"),
                      GestureDetector(
                        onTap: () {
                          RoutingPage.goTonext(
                            context: context,
                            navigateTo: LoginPage(),
                          );
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
