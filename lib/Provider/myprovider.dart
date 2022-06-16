import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  String _id = "";
  String _nom = "";
  String _prenom = "";
  String _email = "";
  String _password = "";
  String _role = "";
  String _img = "";
  String _adresse = "";
  String _num_tel = "";
  String _cv = "";
  String _salaire = "";
  String _image = "";
  String _niveau_scolaire = "";
  late int _nombreclass = 0;
  /*  late ScrollController _controller;

  ScrollController get cotroller => _controller;
  set cotroller(ScrollController) {
    _controller = cotroller;
    notifyListeners();
  } */
  String get image => _image;
  String get id => _id;
  String get nom => _nom;
  String get prenom => _prenom;
  String get email => _email;
  String get password => _password;
  String get role => _role;
  int get nombreclass => _nombreclass;

  set nombreclass(int nombreclass) {
    _nombreclass = nombreclass;
    notifyListeners();
  }

  set id(String id) {
    _id = id;
    notifyListeners();
  }

  set image(String image) {
    _image = image;
    notifyListeners();
  }

  set nom(String nom) {
    _nom = nom;
    notifyListeners();
  }

  set prenom(String prenom) {
    _prenom = prenom;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  set role(String role) {
    _role = role;
    notifyListeners();
  }

  void updateUser(String _nom, String _prenom) {
    nom = _nom;
    prenom = _prenom;
    notifyListeners();
  }

  void updateUserImage(String nomA, String prenomA, String imageA) {
    _nom = nomA;
    _prenom = prenomA;
    _image = imageA;
    notifyListeners();
  }
}
