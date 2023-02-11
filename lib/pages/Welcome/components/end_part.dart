import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/SignUp/signup_page.dart';
import 'package:foodmaps_flutter/route/routing_page.dart';
import 'package:foodmaps_flutter/widgets/my_button.dart';

import '../../login/login_page.dart';

class EndPart extends StatelessWidget {
  const EndPart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: () {
            RoutingPage.goTonext(
              context: context,
              navigateTo: LoginPage(),
            );
          },
          text: "LOG IN",
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            RoutingPage.goTonext(context: context, navigateTo: SignupPage());
          },
          child: Text(
            "SIGN UP",
            style: TextStyle(color: Color(0xff797b7a)),
          ),
        )
      ],
    );
  }
}
