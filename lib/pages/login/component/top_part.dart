import 'package:flutter/material.dart';

class TopPart extends StatelessWidget {
  const TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 7,
            ),
            Text(
              "Welcome back to FoodMAPS!!\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tSIGN IN",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child: Image.asset(
            //     "images/canteen_logo.jpeg",
            //     scale: 3,
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
