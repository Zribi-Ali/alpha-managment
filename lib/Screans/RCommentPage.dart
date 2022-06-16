import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Connection.dart';
import '../Models/Comment.dart';
import '../Models/Publication.dart';
import '../Provider/myprovider.dart';
import 'Publication/publication_serch.dart';

class RCommentAffich extends StatefulWidget {
  const RCommentAffich({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<RCommentAffich> createState() => _RCommentAffichState();
}

class _RCommentAffichState extends State<RCommentAffich> {
  final DemoConnection connection = DemoConnection();
  var commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FiltrePublication(),
              ),
            );
          },
        ),
      ),
      body: FutureBuilder(
          future: connection.fetchPubliucationid(widget.id),
          builder:
              (BuildContext context, AsyncSnapshot<Publiucation> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Row(children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              var currentpubliation = snapshot.data!;
                              List<Comment> tab = [];
                              if (currentpubliation.comments != null &&
                                  currentpubliation.comments!.length > 0) {
                                tab = currentpubliation.comments!;
                              }
                              return Column(
                                children: [
                                  Container(
                                    child: getTextWidgets(tab),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ]),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 244, 244, 244),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Form(
                                key: formKey,
                                child: TextField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Écrire un Commentair',
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  comment(
                                      commentController.text,
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .id,
                                      widget.id);
                                }
                              },
                              icon: const Icon(
                                Icons.send_rounded,
                                size: 32,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
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
          }),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     showDialog(
      //         context: context,
      //         builder: (context) {
      //           return _buildPopupDialog(context);
      //         });
      //   },
      //   icon: const Icon(Icons.comment_rounded),
      //   label: const Text("Ajouter Commentaire"),
      // ),
    );
  }

  Widget getTextWidgets(List<Comment> tab) {
    List<Widget> list = [];
    for (var i = 0; i < tab.length; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          child: Card(
            elevation: 20.0,
            shadowColor: Colors.black87,
            color: Colors.white70,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${tab[i].user.nom} ${tab[i].user.prenom}",
                        style: const TextStyle(
                            fontSize: 8,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${tab[i].content}",
                        style: const TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                  trailing: Text(
                    "${tab[i].createdAt} \n ${tab[i].updatedAt}",
                    style: TextStyle(
                        fontSize: 8, color: Colors.redAccent.shade100),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: list);
  }

  Widget _buildPopupDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 16,
      title: const Text('Ecrire Commentaire'),
      content: Form(
        key: formKey,
        child: TextField(
          controller: commentController,
          decoration: const InputDecoration(hintText: "Commentaire"),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              setState(() {
                comment(
                    commentController.text,
                    Provider.of<MyProvider>(context, listen: false).id,
                    widget.id);
              });
            }
            Navigator.of(context).pop();
          },
          //textColor: Colors.red.shade400,
          child: const Text('Envoyer'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          //textColor: Colors.blue.shade400,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Future<void> comment(String comment, String user, String publication) async {
    if (commentController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("http://192.168.93.26:8888/user/publication/comment"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              {'content': comment, 'user': user, 'publication': publication}));
      if (response.statusCode == 200) {
        setState(() {});
        commentController.text = "";
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Credentials."),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Black Field Not Allowed"),
        ),
      );
    }
  }
}
