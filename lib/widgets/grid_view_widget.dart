import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/widgets/single_product.dart';

import '../appColors/app_colors.dart';
import '../pages/detailPage/details_page.dart';
import '../route/routing_page.dart';

class GridViewWidget extends StatefulWidget {
  final String id;
  final String collection;
  final String subCollection;

  const GridViewWidget({
    Key? key,
    required this.subCollection,
    required this.id,
    required this.collection,
  }) : super(key: key);

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  String query = "";
  var result;
  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["productName"].toUpperCase().contains(query) ||
          element["productName"].toLowerCase().contains(query) ||
          element["productName"].toUpperCase().contains(query) &&
              element["productName"].toLowerCase().contains(query);
    }).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.collection)
            .doc(widget.id)
            .collection(widget.subCollection)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
          if (!snapshort.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var varData = searchFunction(query, snapshort.data!.docs);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 7,
                  shadowColor: Colors.grey[300],
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      fillColor: AppColors.KwhiteColor,
                      hintText: "Search Your Product",
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              result.isEmpty
                  ? Text("Not Item")
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: result.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (ctx, index) {
                        var data = varData[index];
                        return SingleProduct(
                          onTap: () {
                            RoutingPage.goTonext(
                              context: context,
                              navigateTo: DetailsPage(
                                productCategory: data["productCategory"],
                                productId: data["productId"],
                                productImage: data["productImage"],
                                productName: data["productName"],
                                productOldPrice: data["productOldPrice"],
                                productPrice: data["productPrice"],
                                productRate: data["productRate"],
                                productDescription: data["productDescription"],
                              ),
                            );
                          },
                          productId: data["productId"],
                          productCategory: data["productCategory"],
                          productRate: data["productRate"],
                          productOldPrice: data["productOldPrice"],
                          productPrice: data["productPrice"],
                          productImage: data["productImage"],
                          productName: data["productName"],
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


// class GridViewWidget extends StatelessWidget {
//   final String id;
//   final String collection;
//   final String subCollection;
//   const GridViewWidget({
//     Key? key,
//     required this.id,
//     required this.collection,
//     required this.subCollection,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(collection)
//             .doc(id)
//             .collection(subCollection)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
//           if (!snapshort.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Material(
//                   elevation: 7,
//                   shadowColor: Colors.grey[300],
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       fillColor: AppColors.KwhiteColor,
//                       hintText: "Search Your Item",
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               snapshort.data!.docs.isEmpty
//                   ? Text("No Item")
//                   : GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: snapshort.data!.docs.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         childAspectRatio: 0.6,
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 5.0,
//                         crossAxisSpacing: 5.0,
//                       ),
//                       itemBuilder: (context, index) {
//                         var data = snapshort.data!.docs[index];
//                         return SingleProduct(
//                           onTap: () {
//                             RoutingPage.goTonext(
//                               context: context,
//                               navigateTo: DetailsPage(
//                                 productId: data["productId"],
//                                 productCategory: data["productCategory"],
//                                 productName: data["productName"],
//                                 productImage: data["productImage"],
//                                 productOldPrice: data["productOldPrice"],
//                                 productPrice: data["productPrice"],
//                                 productRate: data["productRate"],
//                                 productDescription: data["productDescription"],
//                               ),
//                             );
//                           },
//                           productId: data["productId"],
//                           productCategory: data["productCategory"],
//                           productRate: data["productRate"],
//                           productOldPrice: data["productOldPrice"],
//                           productPrice: data["productPrice"],
//                           productImage: data["productImage"],
//                           productName: data["productName"],
//                         );
//                       },
//                     ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
