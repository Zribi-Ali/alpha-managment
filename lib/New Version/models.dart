import 'package:alpha/Models/Evenement.dart';
import 'package:alpha/Models/Publication.dart';
import 'package:alpha/Screans/evenement/Evenement.dart';
import 'package:alpha/Screans/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Screans/Publication/PublicationPage.dart';
import '../Screans/Publication/publication_serch.dart';
import '../Screans/evenement/evenn.dart';
import '../Screans/formation/fom.dart';

class Place {
  String title;
  String subtitle;
  FaIcon icon;
  final function;

  double height;
  Place(this.title, this.subtitle, this.height, this.function, this.icon);
  static List<Place> generatePlaces() {
    return [
      Place(
        "Publication",
        "Voir toutes les publications et créer la vôtre",
        300,
        const FiltrePublication(),
        FaIcon(
          FontAwesomeIcons.bullhorn,
          color: Color(0xFFF4E6CD),
          size: 80,
        ),
      ),
      Place(
        "Evennement",
        "Voir tout l'événement",
        220,
        const EvenementA(),
        FaIcon(
          FontAwesomeIcons.calendarMinus,
          color: Color(0xFFF4E6CD),
          size: 80,
        ),
      ),
      Place(
        "Formation",
        "Voir toutes les formations",
        320,
        const FormationA(),
        FaIcon(
          FontAwesomeIcons.graduationCap,
          color: Color(0xFFF4E6CD),
          size: 80,
        ),
      ),
      Place(
        "Profile",
        "Voir votre profil",
        220,
        Profile(),
        FaIcon(
          FontAwesomeIcons.user,
          color: Color(0xFFF4E6CD),
          size: 80,
        ),
      ),
    ];
  }
}
