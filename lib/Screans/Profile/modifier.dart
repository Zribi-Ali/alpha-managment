// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:http_parser/http_parser.dart';
import '../../Connection.dart';
import '../../Models/User.dart';
import '../../Provider/myprovider.dart';
import '../../Routes.dart';

class Modify extends StatefulWidget {
  const Modify({Key? key}) : super(key: key);

  @override
  State<Modify> createState() => _ModifyState();
}

class _ModifyState extends State<Modify> {
  File? imag;
  final DemoConnection connection = DemoConnection();
  TextEditingController myControllerpassword = TextEditingController();
  TextEditingController myControllerpassword2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var id = Provider.of<MyProvider>(context).id;
    TextEditingController myControllernom = TextEditingController()
      ..text = Provider.of<MyProvider>(context).nom;
    TextEditingController myControllerprenom = TextEditingController()
      ..text = Provider.of<MyProvider>(context).prenom;
    var image = Provider.of<MyProvider>(context).image;
    final prov = Provider.of<MyProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: Stack(children: [
                    if (imag != null)
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(imag!),
                      )
                    else
                      buildImage(image),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: buildEditIcon(Colors.teal),
                    )
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    controller: myControllernom,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  child: TextFormField(
                    controller: myControllerprenom,
                    minLines: 1,
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Mot de passe actuel"),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    controller: myControllerpassword,
                    minLines: 1,
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Nouveau mot de passe"),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    controller: myControllerpassword2,
                    minLines: 1,
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: MaterialButton(
                    onPressed: () async {
                      await connection.updateuser(context, id,
                          myControllernom.text, myControllerprenom.text, imag);
                      await fetchuser(id);
                      // prov.updateUser(
                      //  myControllernom.text, myControllerprenom.text);
                      Navigator.of(context).pushNamed(RouteManager.profile);
                    },
                    textColor: Colors.white,
                    color: Colors.blueGrey.shade400,
                    elevation: 10,
                    splashColor: Colors.red.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusElevation: 2,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      child: Text(
                        "Modifier",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateuserd(
      context, String idu, String nom, String prenom, File? image) async {
    Dio dio = Dio();
    if (image == null) {
      try {
        FormData formData = FormData.fromMap({
          "nom": nom,
          "prenom": prenom,
        });
        Response response =
            await dio.put("http://192.168.1.19:8888/profil/$idu",
                data: formData,
                options: Options(headers: {
                  "accept": "*/*",
                  "Authorization": "Bearer accresstoken",
                  "Content-Type": "multipart/form-data",
                }));

        context.read<MyProvider>().nom = nom;
        context.read<MyProvider>().prenom = prenom;
      } catch (e) {
        print(e);
      }
    } else {
      try {
        String filename = image.path.split('/').last;
        FormData formData = FormData.fromMap({
          "nom": nom,
          "prenom": prenom,
          "receipt": await MultipartFile.fromFile(image.path,
              filename: filename, contentType: MediaType('image', 'png')),
          "type": "image/png"
        });

        Response response =
            await dio.put("http://192.168.1.19:8888/profil/$idu",
                data: formData,
                options: Options(headers: {
                  "accept": "*/*",
                  "Authorization": "Bearer accresstoken",
                  "Content-Type": "multipart/form-data",
                }));
        context.read<MyProvider>().nom = nom;
        context.read<MyProvider>().prenom = prenom;
        context.read<MyProvider>().image = await MultipartFile.fromFile(
            image.path,
            filename: filename,
            contentType: MediaType('image', 'png'));
      } catch (e) {
        print(e);
      }
    }
  }

  Future fetchuser(id) async {
    var response = await http
        .get(Uri.parse('http://192.168.93.26:8888/admin/user'), headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": 'true',
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      Map formationData = jsonDecode(response.body);
      dynamic formations = formationData['response'];
      for (var i = 0; i < formations.length; i++) {
        if (formations[i]['_id'] == id) {
          Provider.of<MyProvider>(context, listen: false).updateUserImage(
              formations[i]["nom"],
              formations[i]["prenom"],
              formations[i]["receipt"]);
        }
      }
      print(Provider.of<MyProvider>(context, listen: false).nom);
      return formations.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Widget buildImage(image) {
    return ClipOval(
      child: Material(
        child: InkWell(
          onTap: () {
            pickImage();
          },
          child: SizedBox(
              height: 170,
              width: 165,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.imag = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
