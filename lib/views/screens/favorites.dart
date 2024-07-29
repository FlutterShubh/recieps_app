import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    homeController.getAllFavs();
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
          backgroundColor: Colors.red.shade100,
        ),
        body: Consumer<HomeController>(
          builder: (context, homeController, child) => ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(homeController.favList[index].name ?? ""),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            onTap: () async {
                              await homeController.removeFromFav(index);
                            },
                            child: Text("Remove From Favorite"))
                      ];
                    },
                  ),
                );
              },
              itemCount: homeController.favList.length),
        ));
  }
}
