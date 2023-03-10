import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/detailPage/components/second_part.dart';
import 'package:foodmaps_flutter/pages/detailPage/components/top_part.dart';

import '../../appColors/app_colors.dart';

class DetailsPage extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productDescription;
  final double productPrice;
  final double productOldPrice;
  final int productRate;
  final String productId;
  final String productCategory;

  const DetailsPage({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productOldPrice,
    required this.productRate,
    required this.productId,
    required this.productCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Product Description",
          style: TextStyle(
            color: AppColors.KblackColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopPart(
              image: productImage,
            ),
            SecondPart(
              productImage: productImage,
              productId: productId,
              productName: productName,
              productOldPrice: productOldPrice,
              productPrice: productPrice,
              productRate: productRate,
              productDescription: productDescription,
              productCategory: productCategory,
            ),
          ],
        ),
      ),
    );
  }
}
