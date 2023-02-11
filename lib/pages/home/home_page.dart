import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/appColors/app_colors.dart';
import 'package:foodmaps_flutter/model/user_model.dart';
import 'package:foodmaps_flutter/pages/detailPage/details_page.dart';
import 'package:foodmaps_flutter/route/routing_page.dart';
import 'package:foodmaps_flutter/widgets/build_drawer.dart';
import 'package:foodmaps_flutter/widgets/grid_view_widget.dart';
import 'package:foodmaps_flutter/widgets/single_product.dart';

late UserModel userModel;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userModel = UserModel.fromDocument(documentSnapshot);
      } else {
        print("Document does not exist in database");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserDataFunction();
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
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
          ListTile(
            leading: Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            height: 100,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Categories")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                if (!streamSnapshort.hasData) {
                  return Center(child: const CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: streamSnapshort.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    return Categories(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GridViewWidget(
                              collection: streamSnapshort.data!.docs[index]
                                  ["categoryName"],
                              id: streamSnapshort.data!.docs[index].id,
                            ),
                          ),
                        );
                      },
                      categoryName: streamSnapshort.data!.docs[index]
                          ["categoryName"],
                      image: streamSnapshort.data!.docs[index]["categoryImage"],
                    );
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: Text(
              "Products",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            height: 280,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                if (!streamSnapshort.hasData) {
                  return Center(child: const CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: streamSnapshort.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    var data = streamSnapshort.data!.docs[index];
                    return SingleProduct(
                      onTap: () {
                        RoutingPage.goTonext(
                          context: context,
                          navigateTo: DetailsPage(
                            productCategory: data["productCategory"],
                            productId: data["productId"],
                            productName: data["productName"],
                            productImage: data["productImage"],
                            productOldPrice: data["productOldPrice"],
                            productPrice: data["productPrice"],
                            productRate: data["productRate"],
                            productDescription: data["productDescription"],
                          ),
                        );
                      },
                      name: data["productName"],
                      price: data["productPrice"],
                      image: data["productImage"],
                    );
                    // return Categories(
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: Text(
              "Best Sell",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            height: 280,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where("productRate", isGreaterThan: 3)
                  .orderBy(
                    "productRate",
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                if (!streamSnapshort.hasData) {
                  return Center(child: const CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: streamSnapshort.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    var data = streamSnapshort.data!.docs[index];
                    return SingleProduct(
                      onTap: () {
                        RoutingPage.goTonext(
                          context: context,
                          navigateTo: DetailsPage(
                            productCategory: data["productCategory"],
                            productId: data["productId"],
                            productName: data["productName"],
                            productImage: data["productImage"],
                            productOldPrice: data["productOldPrice"],
                            productPrice: data["productPrice"],
                            productRate: data["productRate"],
                            productDescription: data["productDescription"],
                          ),
                        );
                      },
                      name: data["productName"],
                      price: data["productPrice"],
                      image: data["productImage"],
                    );
                    // return Categories(
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String image;
  final String categoryName;
  final Function()? onTap;
  const Categories({
    Key? key,
    required this.onTap,
    required this.categoryName,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12.0),
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.6),
            //used for one sided transparency-->
            // gradient: LinearGradient(
            //   begin: Alignment.center,
            //   colors: [
            //     Colors.black.withOpacity(0.6),
            //     Colors.black.withOpacity(0.6),
            //   ],
            // ),
          ),
          child: Center(
            child: Text(
              categoryName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
