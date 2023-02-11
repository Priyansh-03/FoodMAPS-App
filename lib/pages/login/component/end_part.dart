import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/SignUp/signup_page.dart';

import '../../../route/routing_page.dart';
import '../../../widgets/my_button.dart';

class EndPart extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;

  const EndPart({
    required this.loading,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loading == true
            ? CircularProgressIndicator()
            : MyButton(
                onPressed: onPressed,
                text: "LOGIN",
              ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create a new account?\t\t"),
            GestureDetector(
              onTap: () {
                RoutingPage.goTonext(
                  context: context,
                  navigateTo: SignupPage(),
                );
              },
              child: Text(
                "SIGN UP",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
