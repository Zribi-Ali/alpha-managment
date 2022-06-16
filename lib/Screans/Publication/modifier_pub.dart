import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../../Connection.dart';
import '../../Provider/myprovider.dart';

import 'package:dotted_border/dotted_border.dart';
import '../../Routes.dart';
import 'publication_serch.dart';

class PublicationModifier extends StatefulWidget {
  const PublicationModifier({Key? key, required this.publication})
      : super(key: key);
  final publication;
  @override
  State<PublicationModifier> createState() => _PublicationModifierState();
}

class _PublicationModifierState extends State<PublicationModifier>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    File? _file;
    PlatformFile? _platformFile;
    late AnimationController loadingController;
    final DemoConnection connection = DemoConnection();
    FilePickerResult? result;
    List<PlatformFile> fichers = [];
    PlatformFile? file;
    File? image;
    var _fullname = "";
    selectFile() async {
      final file = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

      if (file != null) {
        setState(() {
          _file = File(file.files.single.path!);
          _platformFile = file.files.first;
        });
      }

      loadingController.forward();
      print(_file!.path);
      print(_platformFile!.name);
      print(_platformFile!.path);
    }

    @override
    void initState() {
      loadingController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
      )..addListener(() {
          setState(() {});
        });

      super.initState();
    }

    @override
    void dispose() {
      super.dispose();
    }

    TextEditingController myControllertitre = TextEditingController()
      ..text = widget.publication.titre;
    TextEditingController myControllerpub = TextEditingController()
      ..text = widget.publication.content;

    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    String id = Provider.of<MyProvider>(context, listen: false).id;
    // ignore: prefer_interpolation_to_compose_strings
    _fullname = Provider.of<MyProvider>(context).nom.toString() +
        " " +
        Provider.of<MyProvider>(context).prenom.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.xmark,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Modifier",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: MaterialButton(
              onPressed: () async {
                connection.updatePublicationid(widget.publication.id,
                    myControllerpub.text, myControllertitre.text);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FiltrePublication(),
                  ),
                );
              },
              textColor: Colors.blue[400],
              color: Colors.white,
              elevation: 0,
              child: const Text(
                "Publier",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Material(
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.network(
                            widget.publication.user.receipt,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      _fullname,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      //label: Text("Titre de publication"),
                      labelStyle: TextStyle(color: Colors.teal),
                    ),
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    controller: myControllertitre,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: myControllerpub,
                    minLines: 1,
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
