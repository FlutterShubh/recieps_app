import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recieps_app/views/widgets/fav_item.dart';

import '../../controllers/home_controller.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = context.read<HomeController>();
    homeController.loadFavs();
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
          backgroundColor: Colors.red.shade100,
        ),
        body: Consumer<HomeController>(
          builder: (context, homeController, child) => Padding(
            padding: const EdgeInsets.all( 8),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return FavItem(title: homeController.favList[index].name ?? "", price: homeController.favList[index].amount.toString() ??"", popUpText: "Remove From Favorite", onTap: () {
                    homeController.removeFromFav(index);
                  },);
                },
                itemCount: homeController.favList.length),
          ),
        ));
  }
}
