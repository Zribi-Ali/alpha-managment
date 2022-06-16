import 'dart:async';

import 'package:alpha/Models/Publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../Connection.dart';
import '../../Models/Formation.dart';
import '../../New Version/new_main.dart';
import 'fomation-D.dart';

final bucketGlobal = PageStorageBucket();

class FormationA extends StatefulWidget {
  const FormationA({Key? key}) : super(key: key);

  @override
  State<FormationA> createState() => _FormationState();
}

class _FormationState extends State<FormationA> {
  final DemoConnection connection = DemoConnection();
  late ScrollController controller;

  bool _showAppbar = true;
  bool isScrollingDown = false;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    controller = ScrollController();
    controller.dispose();
    controller.removeListener(() {});
    super.dispose();
    //context.read<MyProvider>().cotroller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              height: 45.0,
              duration: const Duration(milliseconds: 400),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                title: const Text(
                  'Formation',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageStorage(
                bucket: bucketGlobal,
                child: FutureBuilder(
                  future: connection.fetchFormation(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Formation>> snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          Expanded(
                            child: RefreshIndicator(
                              displacement: 100,
                              edgeOffset: 10,
                              strokeWidth: 3,
                              color: Colors.teal,
                              onRefresh: _refresh,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  key: const PageStorageKey<String>('pageOne'),
                                  controller: controller,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var currentformation =
                                        snapshot.data![index];

                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .9,
                                      child: Column(
                                        children: [
                                          FormationD(
                                            formation: currentformation,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
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
            ),
          ],
        ),
      ),
    );
  }

  Widget formation(formation) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: const Color(0xFFF5F5F5),
        elevation: 22,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(-0.82, 0.75),
              child: Text(
                "DATE FIN DE FORMATION ${formation.datefin}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.82, 0.34),
              child: Text(
                "DURÉE DE FORMATION ${formation.duree}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.82, 0.65),
              child: Text(
                "DATE DÉBUT DE FORMATION ${formation.datedebut}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.82, 0.45),
              child: Text(
                "PRIX DE FORMATION ${formation.prix}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.82, -0.36),
              child: Row(
                children: [
                  Text(
                    "TYPE DE FORMATION ",
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    " ${formation.type}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1, -0.9),
              child: Container(
                width: 160,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  formation.img,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 10, 8),
              child: Align(
                alignment: const AlignmentDirectional(-0.3, -0.1),
                child: Text(
                  formation.description,
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.5,
                    wordSpacing: 1.1,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.36, -0.72),
              child: Text(
                formation.nom,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }
}
