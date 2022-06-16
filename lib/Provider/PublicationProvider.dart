import 'package:alpha/Models/Publication.dart';
import 'package:flutter/material.dart';

import '../Connection.dart';

class DataPublication extends ChangeNotifier {
  final DemoConnection connection = DemoConnection();

  List<Publiucation> publications = [];
  bool loading = true;

  getPublicationsData() async {
    loading = true;
    publications = (await connection.fetchPubliucation());
    loading = false;

    notifyListeners();
  }
}
