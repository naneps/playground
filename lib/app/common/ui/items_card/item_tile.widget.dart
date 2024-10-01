import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/icons/burger.png',
                  ),
                ),
                backgroundBlendMode: BlendMode.color),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              "SOLD OUT",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black87,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            children: [
              Text(
                "Birger King",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Hamburger",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                "2.000.000",
              ),
            ],
          ),
          const Spacer(),
          IconButton.filled(
            onPressed: () {},
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black),
            ),
            icon: Icon(
              MdiIcons.plus,
            ),
          )
        ],
      ),
    );
  }
}
