import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/widgets/single_product.dart';

import '../appColors/app_colors.dart';
import '../pages/detailPage/details_page.dart';
import '../route/routing_page.dart';

class GridViewWidget extends StatelessWidget {
  final String id;
  final String collection;
  const GridViewWidget({
    Key? key,
    required this.id,
    required this.collection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Categories")
            .doc(id)
            .collection(collection)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
          if (!snapshort.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 7,
                  shadowColor: Colors.grey[300],
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      fillColor: AppColors.KwhiteColor,
                      hintText: "Search Your Item",
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: snapshort.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.6,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                itemBuilder: (context, index) {
                  var data = snapshort.data!.docs[index];
                  return SingleProduct(
                    onTap: () {
                      RoutingPage.goTonext(
                        context: context,
                        navigateTo: DetailsPage(
                          productName: data["productName"],
                          productImage: data["productImage"],
                          productOldPrice: data["productOldPrice"],
                          productPrice: data["productPrice"],
                          productRate: data["productRate"],
                          productDescription: data["productDescription"],
                        ),
                      );
                    },
                    image: data["productImage"],
                    name: data["productName"],
                    price: data["productPrice"],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
