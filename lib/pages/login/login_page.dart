import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/login/component/center_part.dart';
import 'package:foodmaps_flutter/pages/login/component/end_part.dart';
import 'package:foodmaps_flutter/pages/login/component/login_auth_provider.dart';
import 'package:foodmaps_flutter/pages/login/component/top_part.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    LoginAuthProvider loginAuthProvider =
        Provider.of<LoginAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Top part
            TopPart(),
            //Center part
            CenterPart(
                email: email,
                password: password,
                obscureText: visible,
                onPressed: () {
                  setState(() {
                    visible = !visible;
                    print(visible);
                  });
                },
                icon: Icon(visible ? Icons.visibility_off : Icons.visibility)),
            //End Part
            EndPart(
              loading: loginAuthProvider.loading,
              onPressed: (() {
                loginAuthProvider.loginPageValidation(
                  emailAdress: email,
                  password: password,
                  context: context,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
