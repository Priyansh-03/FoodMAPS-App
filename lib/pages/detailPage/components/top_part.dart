import 'package:flutter/material.dart';

class TopPart extends StatelessWidget {
  final String image;

  const TopPart({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image)),
        ),
      ),
    );
  }
}
