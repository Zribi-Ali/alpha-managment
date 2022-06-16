import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Connection.dart';
import '../../Models/Publication.dart';
import '../../Provider/myprovider.dart';

class ListPublication extends StatefulWidget {
  const ListPublication({super.key});

  @override
  State<ListPublication> createState() => _ListPublicationState();
}

class _ListPublicationState extends State<ListPublication> {
  final DemoConnection connection = DemoConnection();
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller = ScrollController();
    controller.dispose();
    super.dispose();
    //context.read<MyProvider>().cotroller;
  }

  @override
  Widget build(BuildContext context) {
    final List ids = [];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              height: 50.0,
              duration: const Duration(milliseconds: 400),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                title: const Center(
                  child: Text(
                    'List Publication',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: connection.fetchPubliucation(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Publiucation>> snapshot) {
                  if (snapshot.hasData) {
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      if (Provider.of<MyProvider>(context).id ==
                          snapshot.data![i].user!.id) {
                        ids.add(snapshot.data![i]);
                      }
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    controller: controller,
                                    shrinkWrap: true,
                                    itemCount: ids.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var currentpubliation =
                                          snapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: pub(currentpubliation),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    print("${snapshot.error} ******");
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

  Widget pub(publication) {
    return Card(
      elevation: 20,
      shadowColor: Colors.pink.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Text(publication.titre),
        trailing: FaIcon(
          FontAwesomeIcons.trash,
          color: Colors.pink.shade600,
        ),
        onTap: () {},
      ),
    );
  }
}
