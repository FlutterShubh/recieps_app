import 'package:flutter/material.dart';

class FavItem extends StatelessWidget {
  final String title;
  final String price;
  final String popUpText;
  final void Function() onTap;
  const FavItem(
      {super.key,
      required this.title,
      required this.price,
      required this.popUpText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text("Price : $price USD"),
              ],
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [PopupMenuItem(onTap: onTap, child: Text(popUpText))];
            },
          ),
        ],
      ),
    );
    ;
  }
}
