import 'package:flutter/material.dart';

import 'package:foodmaps_flutter/appColors/app_colors.dart';
import 'package:foodmaps_flutter/pages/home/home_page.dart';
import 'package:foodmaps_flutter/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/single_cart_item.dart';
import '../provider/cart_provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late Razorpay _razorpay;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': num.parse(totalPrice.toString()) * 100,
      'name': userModel.fullName,
      'description': 'Payment Gateway',
      'prefill': {
        'contact': '91',
        'email': userModel.emailAddress,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occured while opening PaymentGateway'),
        ),
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // print("Payment Success");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Successfull'),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Error'),
      ),
    );
    print(PaymentFailureResponse);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('External Wallet'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    double subtotal = cartProvider.subTotal();

    double discount = 5;
    int shipping = 10;

    double discountValue = (subtotal * discount) / 100;

    double value = subtotal - discountValue;

    totalPrice = value += shipping;

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
                          onPressed: () {
                            openCheckout();
                          },
                          text: "Place Order",
                        ),
                ],
              ),
            ),
          ],
        ));
  }
}
