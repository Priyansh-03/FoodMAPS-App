import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/grid_view_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridViewWidget(
      collection: "Favorite",
      subCollection: "UserFavorite",
      id: FirebaseAuth.instance.currentUser!.uid,
    );
  }
}
