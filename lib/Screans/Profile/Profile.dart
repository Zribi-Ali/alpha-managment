import 'package:alpha/Provider/myprovider.dart';
import 'package:alpha/Screans/Profile/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Routes.dart';
import 'Number.dart';
import 'image.dart';
import 'modifier.dart';

class Profile extends StatelessWidget {
  Profile({
    Key? key,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  var image;
  //final VoidCallback onClicked;
  var _fullname = "";
  @override
  Widget build(BuildContext context) {
    _fullname =
        "${Provider.of<MyProvider>(context).nom} ${Provider.of<MyProvider>(context).prenom}";
    image = Provider.of<MyProvider>(context).image;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteManager.newpage);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Stack(
                  children: [buildImage()],
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              buildName(context),
              const SizedBox(
                height: 18.0,
              ),
              const Center(
                child: ButtonWidget(
                  text: 'Modifier Profile',
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              NumbersWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        child: SizedBox(
          height: 170,
          width: 165,
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildName(context) => Column(
        children: [
          Text(
            _fullname,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ), // Text
          const SizedBox(height: 4),
          Text(
            Provider.of<MyProvider>(context).email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => const ButtonWidget(
        text: 'Modifier Profile',
      );
}
