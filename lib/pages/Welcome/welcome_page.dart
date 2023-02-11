import 'package:flutter/material.dart';

import 'components/center_part.dart';
import 'components/end_part.dart';
import 'components/top_part.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            //top part
            TopPart(),

            //Center Part
            CenterPart(),

            //End Part
            EndPart(),
          ],
        ),
      ),
    ));
  }
}
