import 'package:alpha/Models/Classe.dart';
import 'package:alpha/Provider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Connection.dart';
import 'cours.dart';

class ClassA extends StatefulWidget {
  final idclass;
  const ClassA({Key? key, required this.idclass}) : super(key: key);

  @override
  State<ClassA> createState() => _ClassAState();
}

class _ClassAState extends State<ClassA> {
  DemoConnection connection = DemoConnection();
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller = ScrollController();
    super.dispose();
    //context.read<MyProvider>().cotroller;
  }

  @override
  Widget build(BuildContext context) {
    DemoConnection connection = DemoConnection();
    var role = Provider.of<MyProvider>(context).role;
    final List ids = [];
    final List listCours = [];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: connection.fetchClass(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Class>> snapshot) {
              if (snapshot.hasData) {
                for (var i = 0; i < snapshot.data!.length; i++) {
                  if (widget.idclass == snapshot.data![i].id) {
                    ids.add(snapshot.data![i]);
                    for (var j = 0; j < snapshot.data![i].cours!.length; j++) {
                      listCours.add(snapshot.data![i].cours![j]);
                    }
                  }
                }

                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                key: const PageStorageKey<String>('pageOne'),
                                controller: controller,
                                itemCount: ids.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var currentclass = ids[index];
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    width: double.infinity,
                                    child: role == "proffeseur"
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      96, 191, 190, 190),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                    bottomRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 2),
                                                height: 70,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      leading: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: const Icon(
                                                          Icons.arrow_back,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        "${currentclass.nom}",
                                                        style: const TextStyle(
                                                            fontSize: 22.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: IconButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Cours(
                                                                idclasse: widget
                                                                    .idclass,
                                                                listcours:
                                                                    listCours,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.picture_as_pdf,
                                                          size: 40,
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    buildClass(currentclass)
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                height: 100.0,
                                                duration: const Duration(
                                                    milliseconds: 400),
                                                child: AppBar(
                                                  backgroundColor:
                                                      Colors.transparent,
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
                                                  title: Text(
                                                    "${currentclass.nom}",
                                                    style: const TextStyle(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: buildClass(currentclass),
                                              )
                                            ],
                                          ),
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
      ),
    );
  }

  Widget buildClass(data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.etudiant.length,
      itemBuilder: (context, index) {
        final item = data.etudiant[index];
        return Card(
          elevation: 8,
          shadowColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: ListTile(
            leading: ClipOval(
              child: Material(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    item.receipt,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text("${item.nom} ${item.prenom}"),
          ),
        );
      },
    );
  }
}
