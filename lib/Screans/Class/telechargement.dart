import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Telecharger extends StatefulWidget {
  final String cour;

  const Telecharger({super.key, required this.cour});
  @override
  State<Telecharger> createState() => _HomeState();
}

class _HomeState extends State<Telecharger> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var progress;
    int receivedd;
    int totall;
    String progressString;
    bool tel = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Download File from URL"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Text("Nom de fichier: ${widget.cour.split('/').last}"),
            Divider(),
            ElevatedButton(
              onPressed: () async {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.storage,
                  //add more permission to request here.
                ].request();

                if (statuses[Permission.storage]!.isGranted) {
                  var dir = await DownloadsPathProvider.downloadsDirectory;
                  if (dir != null) {
                    String savename = widget.cour.split('/').last;
                    String savePath = dir.path + "/$savename";
                    print(savePath);

                    try {
                      await Dio().download(widget.cour, savePath,
                          onReceiveProgress: (received, total) {
                        if (total != -1) {
                          print((received / total * 100).toStringAsFixed(0) +
                              "%");
                        }
                      });
                      print("File is saved to download folder.");
                    } on DioError catch (e) {
                      print(e.message);
                    }
                  }
                } else {}
              },
              child: const Text("Download File."),
            ),
            tel == true
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          'Linear progress indicator with a fixed color',
                          style: TextStyle(fontSize: 20),
                        ),
                        LinearProgressIndicator(
                          value: controller.value,
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  )
          ],
        ),
      ),
    );
  }
}
