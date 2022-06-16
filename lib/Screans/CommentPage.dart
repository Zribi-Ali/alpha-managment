// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:alpha/Screans/Publication/PublicationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Connection.dart';
import '../Models/Classe.dart';
import '../Models/Comment.dart';
import '../New Version/new_main.dart';
import '../Provider/myprovider.dart';
import 'RCommentPage.dart';

class CommentesAff extends StatefulWidget {
  const CommentesAff({
    Key? key,
    required this.listcommentair,
    required this.id_publication,
  }) : super(key: key);
  final List<Comment> listcommentair;
  final String id_publication;

  @override
  State<CommentesAff> createState() => _CommentesAffState();
}

final DemoConnection connection = DemoConnection();

class _CommentesAffState extends State<CommentesAff> {
  var commentController = TextEditingController();
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
    var list = widget.listcommentair;
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AnimatedContainer(
              height: _showAppbar ? 100.0 : 0.0,
              duration: const Duration(milliseconds: 350),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AffichPublication(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                title: const Text(
                  'Commentairs ',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 75, top: 60),
                    child: getTextWidgets(list),
                  ),
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
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
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
                                    widget.id_publication);
                                setState(() {});
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
            ),
          ],
        ),
        /*  floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return _buildPopupDialog(context);
                });
          },
          icon: const Icon(
            Icons.comment_rounded,
            size: 12,
          ),
          label: const Text(
            "Ajouter Commentaire",
            style: TextStyle(fontSize: 10),
          ),
        ), */
      ),
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
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              setState(() {
                comment(
                    commentController.text,
                    Provider.of<MyProvider>(context, listen: false).id,
                    widget.id_publication);
              });
            }
            Navigator.of(context).pop();
          },
          //  textColor: Colors.red.shade400,
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
          Uri.parse("http://192.168.1.19:8888/user/publication/comment"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              {'content': comment, 'user': user, 'publication': publication}));
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RCommentAffich(
              id: widget.id_publication,
            ),
          ),
        );
        // setState(() {});
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
