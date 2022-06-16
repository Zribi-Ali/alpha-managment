import 'dart:io';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:alpha/Provider/myprovider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../Connection.dart';
import 'telechargement.dart';

class Cours extends StatefulWidget {
  final idclasse;
  final listcours;
  const Cours({super.key, required this.idclasse, required this.listcours});

  @override
  State<Cours> createState() => _ProfEtudState();
}

class _ProfEtudState extends State<Cours> with SingleTickerProviderStateMixin {
  late AnimationController loadingController;
  File? _file;
  PlatformFile? _platformFile;
  late ScrollController controller;
  selectFile() async {
    final file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

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
    controller = ScrollController();
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
    controller = ScrollController();
    super.dispose();
  }

  DemoConnection connection = DemoConnection();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35)),
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: widget.listcours.length,
                      itemBuilder: (BuildContext context, int index) {
                        var currentcours = widget.listcours[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              child: cardCours(currentcours),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                            onPressed: () {
                              connection.ajouterCours(
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .id,
                                  widget.idclasse,
                                  _file!);
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text("Valider"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: selectFile,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              color: Colors.blue.shade400,
                              child: Container(
                                width: double.infinity,
                                height: 130,
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
                              padding: const EdgeInsets.all(10),
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
                                    height: 6,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
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
                                            child: const Icon(
                                              Icons.picture_as_pdf_rounded,
                                              size: 50,
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
                                                    color:
                                                        Colors.grey.shade500),
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
                                                  value:
                                                      loadingController.value,
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
                                    height: 15,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardCours(cours) {
    return Card(
      elevation: 20,
      shadowColor: Colors.pink.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(cours.content.split('/').last),
        leading: Icon(
          Icons.picture_as_pdf,
          color: Colors.pink.shade600,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                _buildPopupDialog(context, cours),
          );
        },
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, cour) {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => Telecharger(
                    cour: cour.content,
                  ),
                ),
              );
            },
            child: const FaIcon(
              FontAwesomeIcons.download,
              color: Colors.blueAccent,
              size: 50,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerFromUrl(url: cour.content),
                ),
              );
            },
            child: const FaIcon(
              FontAwesomeIcons.filePdf,
              color: Colors.redAccent,
              size: 50,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Url'),
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
