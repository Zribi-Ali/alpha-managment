import 'package:alpha/Screans/Profile/Profile.dart';
import 'package:alpha/tests/logintest.dart';
import 'package:flutter/material.dart';
import 'New Version/new_main.dart';
import 'Screans/Formateur.dart';
import 'Screans/LoginPage.dart';
import 'Screans/Publication/PublicationPage.dart';
import 'Screans/Publication/publication_serch.dart';
import 'main/test/HomePageT.dart';
import 'Screans/evenement/Evenement.dart';
import 'tests/test.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String publication = '/publication';
  static const String classPage = '/classPage';
  static const String maiPage = '/maiPage';
  static const String profile = '/profile';
  static const String evenement = '/evenement';
  static const String formatuer = '/formatuer';
  static const String newpage = '/newpage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => HomePageL(),
        );
      case maiPage:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case newpage:
        return MaterialPageRoute(
          builder: (context) => NewMain(),
        );
      case formatuer:
        return MaterialPageRoute(
          builder: (context) => Formateur(),
        );
      case publication:
        return MaterialPageRoute(
          builder: (context) => FiltrePublication(),
        );

      case profile:
        return MaterialPageRoute(
          builder: (context) => Profile(),
        );
      case evenement:
        return MaterialPageRoute(
          builder: (context) => EvenementAff(),
        );

      default:
        throw FormatException("Route not found! Check routes again");
    }
  }
}
