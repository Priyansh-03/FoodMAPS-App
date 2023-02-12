import 'package:flutter/material.dart';

import 'package:foodmaps_flutter/appColors/app_colors.dart';
import 'package:foodmaps_flutter/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/single_cart_item.dart';
import '../provider/cart_provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    double subtotal = cartProvider.subTotal();

    double discount = 5;
    int shipping = 10;

    double discountValue = (subtotal * discount) / 100;

    double value = subtotal - discountValue;

    double totalPrice = value += shipping;

    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        totalPrice = 0.0;
      });
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Check Out",
            style: TextStyle(
              color: AppColors.KblackColor,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: cartProvider.getCartList.isEmpty
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
            ),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: Text("Sub total"),
                    trailing: Text("$subtotal ₹"),
                  ),
                  ListTile(
                    leading: Text("Discount"),
                    trailing: Text("$discountValue %"),
                  ),
                  ListTile(
                    leading: Text("Shipping"),
                    trailing: Text("$shipping ₹"),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Text("Total"),
                    trailing: Text("$totalPrice ₹"),
                  ),
                  cartProvider.getCartList.isEmpty
                      ? Text("")
                      : MyButton(
                          onPressed: () {},
                          text: "Place Order",
                        ),
                ],
              ),
            ),
          ],
        ));
  }
}
