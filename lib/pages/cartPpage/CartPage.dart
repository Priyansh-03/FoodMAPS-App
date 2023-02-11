import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/widgets/my_button.dart';
import 'package:foodmaps_flutter/widgets/single_cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyButton(
        onPressed: (() {}),
        text: "Check Out",
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Cart")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("UserCart")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
          if (!streamSnapshort.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: streamSnapshort.data!.docs.length,
            itemBuilder: (ctx, index) {
              var data = streamSnapshort.data!.docs[index];
              return SingleCartItem(
                productId: data["productId"],
                productCategory: data["productCategory"],
                productImage: data["productImage"],
                productPrice: data["productPrice"],
                productQuantity: data["productQuantity"],
                productName: data["productName"],
              );
            },
          );
        },
      ),
    );
  }
}
