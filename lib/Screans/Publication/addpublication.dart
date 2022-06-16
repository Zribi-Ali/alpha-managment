import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import '../../Connection.dart';
import '../../Provider/myprovider.dart';
import '../../Routes.dart';

import 'dart:convert';

import 'publication_serch.dart';

class AddPublication extends StatefulWidget {
  const AddPublication({Key? key}) : super(key: key);

  @override
  State<AddPublication> createState() => _AddPublicationState();
}

class _AddPublicationState extends State<AddPublication>
    with SingleTickerProviderStateMixin {
  final DemoConnection connection = DemoConnection();
  bool result = false;
  List<PlatformFile> fichers = [];
  PlatformFile? file;
  File? image;
  var _fullname = "";
  late TextEditingController pubController;
  late TextEditingController titreController;
  bool isButtonActivate = true;

  late AnimationController loadingController;
  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
        result = true;
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

    pubController = TextEditingController();
    titreController = TextEditingController();
    pubController.addListener(() {
      final isButtonActivateP = pubController.text.isEmpty;

      setState(() {
        this.isButtonActivate = isButtonActivateP;
      });
    });
    titreController.addListener(() {
      final isButtonActivateT = pubController.text.isEmpty;

      setState(() {
        this.isButtonActivate = isButtonActivateT;
      });
    });
  }

  @override
  void dispose() {
    pubController.dispose();
    titreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = Provider.of<MyProvider>(context).id;

    _fullname =
        "${Provider.of<MyProvider>(context).nom} ${Provider.of<MyProvider>(context).prenom}";
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
          "Ajouter",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: MaterialButton(
              onPressed: (result == false && isButtonActivate)
                  ? null
                  : () async {
                      connection.createPub(id, _fullname, pubController.text,
                          titreController.text, _file);
                      isButtonActivate = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FiltrePublication(),
                        ),
                      );
                      pubController.clear();
                      titreController.clear();
                    },
              textColor: (result == false && isButtonActivate)
                  ? Colors.grey
                  : Colors.blue[400],
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
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Material(
                            child: SizedBox(
                              height: 70,
                              width: 70,
                              child: Image.network(
                                Provider.of<MyProvider>(context).image,
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
                          style: const TextStyle(
                              fontSize: 22, color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Titre de publication"),
                        //labelStyle: TextStyle(color: Colors.teal),
                      ),
                      minLines: 1,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      controller: titreController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Content de publication"),
                        //labelStyle: TextStyle(color: Colors.teal, fontSize: 15),
                      ),
                      minLines: 1,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      controller: pubController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: selectFile,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            color: Colors.blue.shade400,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Iconsax.folder_open,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Sélectionnez votre fichier',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    _platformFile != null
                        ? Container(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fichier sélectionné',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: const Offset(0, 1),
                                          blurRadius: 3,
                                          spreadRadius: 2,
                                        )
                                      ]),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            _file!,
                                            width: 70,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _platformFile!.name,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${(_platformFile!.size / 1024).ceil()} KB',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade500),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 5,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.blue.shade50,
                                              ),
                                              child: LinearProgressIndicator(
                                                value: loadingController.value,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // MaterialButton(
                                //   minWidth: double.infinity,
                                //   height: 45,
                                //   onPressed: () {},
                                //   color: Colors.black,
                                //   child: Text('Upload', style: TextStyle(color: Colors.white),),
                                // )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget files(List<PlatformFile> ficher) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 150,
          ),
          itemCount: ficher.length,
          itemBuilder: (context, index) {
            final file = ficher[index];
            return buildFile(file);
          }),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toString()} KB';
    final extension = file.extension ?? 'none';
    Color color = Colors.black12;

    if (extension == 'pdf') {
      color = Colors.red.shade400;
    } else if (extension == 'docx' ||
        extension == 'dot' ||
        extension == 'dotm') {
      color = Colors.blue.shade300;
    } else if (extension == 'png' ||
        extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'bmp') {
      color = Colors.green.shade300;
    } else if (extension == 'gif' || extension == 'tiff') {
      color = Colors.pink.shade300;
    }

    return InkWell(
      onTap: () => OpenFile.open(file.path!),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  extension,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              file.name,
              style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fileSize,
              style: const TextStyle(fontSize: 12.5, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class FileConverter {
  static getBase64FormateFile(String path) {
    File file = File(path);
    print('File is = ' + file.toString());
    List<int> fileInByte = file.readAsBytesSync();
    var fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }
}

/*
  void pickFiless() async {
    result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'dot', 'dotm']);
    if (result == null) return;
    loadSelectedFile(result!.files);
  }

  void loadSelectedFile(List<PlatformFile> files) {}

  void openFiles(List<PlatformFile> files) => FilesPage(
        files: files,
        onOpenedFile: openFile,
      );

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Widget FilesPage(
      {required List<PlatformFile> files,
      required void Function(PlatformFile file) onOpenedFile}) {
    return Center(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return buildFile(file);
          }),
    );
  }

  */