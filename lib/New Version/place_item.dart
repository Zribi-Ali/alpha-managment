import 'package:flutter/material.dart';

import 'models.dart';

class PlaceItem extends StatelessWidget {
  final Place place;
  PlaceItem(this.place);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
          context, MaterialPageRoute(builder: (context) => place.function))),
      child: Container(
        alignment: Alignment.bottomLeft,
        height: place.height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: place.icon,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                place.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                place.subtitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
