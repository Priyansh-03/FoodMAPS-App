import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final double price;
  final String name;
  final Function()? onTap;

  const SingleProduct({
    Key? key,
    required this.onTap,
    required this.name,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "$price ₹",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
