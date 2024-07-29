import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recieps_app/controllers/home_controller.dart';
import 'package:recieps_app/views/screens/favorites.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = context.read<HomeController>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Recipes"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Favorites(),
                      ));
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ))
          ],
          backgroundColor: Colors.red.shade100,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "Search"
                        ),
                      ),
                    ),
                    IconButton(onPressed:() {
                    }, icon: Icon(Icons.search,size: 30,))
                  ],
                ),
              ),
              Expanded(
                child: Consumer<HomeController>(
                  builder: (context, value, child) => ListView.builder(
                      itemBuilder: (context, index) {
                        final HomeController homeController =
                            context.watch<HomeController>();
                        return ListTile(
                          title: Text(homeController.recipe?.recipes.first
                                  .extendedIngredients?[index].name ??
                              ""),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                    onTap: () async {
                                      await homeController.addToFav(index);
                                    },
                                    child: Text("Add From Favorite"))
                              ];
                            },
                          ),
                        );
                      },
                      itemCount: 5),
                ),
              ),
            ],
          ),
        ));
  }
}
