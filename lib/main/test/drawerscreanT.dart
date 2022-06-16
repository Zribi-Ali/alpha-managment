import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../Provider/myprovider.dart';
import '../../Routes.dart';
import '../../Screans/Profile/Profile.dart';

class DrowerScreane extends StatefulWidget {
  const DrowerScreane({Key? key}) : super(key: key);

  @override
  _DrowerScreaneState createState() => _DrowerScreaneState();
}

class _DrowerScreaneState extends State<DrowerScreane> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xff416d6d),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 50.0,
                /* backgroundImage: NetworkImage(
                "https://uifaces.co/our-content/donated/gPZwCbdS.jpg"),*/
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Text(Provider.of<MyProvider>(context).nom,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width * 0.56,
                child: MaterialButton(
                  color: const Color.fromARGB(255, 126, 193, 193),
                  elevation: 0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 18.0,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Deconnextion",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ]),
                  onPressed: () {
                    context.read<MyProvider>().id = "";
                    context.read<MyProvider>().nom = "";
                    context.read<MyProvider>().prenom = "";
                    context.read<MyProvider>().email = "";
                    context.read<MyProvider>().role = "";
                    context.read<MyProvider>().password = "";

                    Navigator.of(context).pushNamed(RouteManager.loginPage);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width * 0.56,
                child: MaterialButton(
                  color: const Color.fromARGB(255, 126, 193, 193),
                  elevation: 0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18.0,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ]),
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: Profile(),
                      withNavBar: false,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
