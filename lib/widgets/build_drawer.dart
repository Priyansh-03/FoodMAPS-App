import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/Welcome/welcome_page.dart';
import 'package:foodmaps_flutter/pages/cartPpage/CartPage.dart';
import 'package:foodmaps_flutter/pages/home/home_page.dart';
import 'package:foodmaps_flutter/pages/profile/profile_page.dart';
import 'package:foodmaps_flutter/route/routing_page.dart';

import '../pages/login/login_page.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            accountName: Text(userModel.fullName),
            accountEmail: Text(userModel.emailAddress),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/non_profile.jpg"),
            ),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: ProfilePage(),
              );
            },
            leading: Icon(
              Icons.person,
            ),
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: CartPage(),
              );
            },
            leading: Icon(
              Icons.shopping_cart_rounded,
            ),
            title: Text("Cart"),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: HomePage(),
              );
            },
            leading: Icon(
              Icons.favorite,
            ),
            title: Text("Favorite"),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: HomePage(),
              );
            },
            leading: Icon(
              Icons.shopping_basket_sharp,
            ),
            title: Text("My Order"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    ),
                  );
            },
            leading: Icon(
              Icons.exit_to_app,
            ),
            title: Text("Log out"),
          )
        ],
      ),
    );
  }
}
