// ignore_for_file: unrelated_type_equality_checks

import 'package:alpha/Provider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Connection.dart';
import '../../Models/Classe.dart';
import 'class.dart';

class ListClass extends StatefulWidget {
  const ListClass({super.key});

  @override
  State<ListClass> createState() => _ListClassState();
}

class _ListClassState extends State<ListClass> {
  final DemoConnection connection = DemoConnection();
  late ScrollController controller;
  var c;
  final List ids = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 55.0,
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: connection.fetchClass(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Class>> snapshot) {
                  if (snapshot.hasData) {
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      for (var j = 0;
                          j < snapshot.data![i].proffeseur!.length;
                          j++) {
                        if (Provider.of<MyProvider>(context).id ==
                            snapshot.data![i].proffeseur![j].id) {
                          ids.add(snapshot.data![i]);
                        }
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              children: List.generate(
                                ids.length,
                                (index) {
                                  return Center(
                                    child: cardClass(ids[index]),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 82.0,
                      ),
                    );
                  }

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Chargement en cours ...")
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardClass(classs) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassA(
              idclass: classs.id,
            ),
          ),
        );
      },
      child: Card(
        elevation: 20,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Colors.yellow,
                Colors.orangeAccent,
                Colors.yellow.shade300,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Expanded(
              child: Text(classs.nom),
            ),
          ),
        ),
      ),
    );
  }
}
