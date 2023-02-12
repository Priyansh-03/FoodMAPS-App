import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/widgets/my_button.dart';
import 'package:foodmaps_flutter/widgets/single_cart_item.dart';
import 'package:provider/provider.dart';

import '../../appColors/app_colors.dart';
import '../../route/routing_page.dart';
import '../Checkout/Check_out_page.dart';
import '../provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    return Scaffold(
      bottomNavigationBar: cartProvider.getCartList.isEmpty
          ? Text("")
          : MyButton(
              text: "Check Out",
              onPressed: () {
                RoutingPage.goTonext(
                  context: context,
                  navigateTo: CheckOutPage(),
                );
              },
            ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: cartProvider.getCartList.isEmpty
          ? Center(
              child: Text("Your Cart is Empty"),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cartProvider.getCartList.length,
              itemBuilder: (ctx, index) {
                var data = cartProvider.cartList[index];
                return SingleCartItem(
                  productId: data.productId,
                  productCategory: data.productCategory,
                  productImage: data.productImage,
                  productPrice: data.productPrice,
                  productQuantity: data.productQuantity,
                  productName: data.productName,
                );
              },
            ),
    );
  }
}


//     return Scaffold(
//       bottomNavigationBar: cartProvider.getCartList.isEmpty
//           ? Text("")
//           : MyButton(
//               onPressed: () {
//                 RoutingPage.goTonext(
//                   context: context,
//                   navigateTo: CheckOutPage(),
//                 );
//               },
//               text: "Check Out",
//             ),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: Text(
//           "Cart",
//           style: TextStyle(
//             color: AppColors.KblackColor,
//           ),
//         ),
//       ),
//       body: cartProvider.getCartList.isEmpty
//           ? Center(
//               child: Text("Your Cart is Empty"),
//             )
//           : ListView.builder(
//               physics: BouncingScrollPhysics(),
//               itemCount: cartProvider.getCartList.length,
//               itemBuilder: (ctx, index) {
//                 var data = cartProvider.cartList[index];
//                 return SingleCartItem(
//                   productId: data.productId,
//                   productCategory: data.productCategory,
//                   productImage: data.productImage,
//                   productPrice: data.productPrice,
//                   productQuantity: data.productQuantity,
//                   productName: data.productName,
//                 );
//               },
//             ),
//     );
//   }
// }
