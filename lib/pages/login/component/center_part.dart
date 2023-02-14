import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/forgetPassword/forget_password.dart';
import 'package:foodmaps_flutter/route/routing_page.dart';

class CenterPart extends StatelessWidget {
  final bool obscureText;
  final TextEditingController? email;
  final TextEditingController? password;
  final Widget icon;
  final void Function()? onPressed;

  const CenterPart({
    required this.obscureText,
    required this.icon,
    required this.email,
    required this.password,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: email,
          decoration: InputDecoration(
            hintText: "Email",
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          controller: password,
          decoration: InputDecoration(
            counter: GestureDetector(
              onTap: () {
                RoutingPage.goTonext(
                  context: context,
                  navigateTo: ForgetPassword(),
                );
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            hintText: "Password",
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: icon,
            ),
          ),
        ),
      ],
    );
  }
}
