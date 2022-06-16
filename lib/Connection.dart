import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:http_parser/http_parser.dart';
import '../Models/Classe.dart';
import '../Models/Evenement.dart';
import '../Models/Formation.dart';
import '../Models/Publication.dart';
import 'dart:io';

import 'Models/User.dart';

var x = "http://192.168.93.26:8888";

class DemoConnection {
  Future<User> fetchoneuser(id) async {
    var response = await http.get(Uri.parse('$x/user/profil/$id'), headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": 'true',
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      dynamic user = data['response'];
      return user.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future<Class> fetchoneclasse(id) async {
    var response = await http.get(Uri.parse('$x/classe/$id'), headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": 'true',
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      dynamic user = data['response'];
      return user.map((json) => Class.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future<void> participe(idev, idu) async {
    await http.patch(
      Uri.parse("$x/evenement/participe/$idev"),
      body: {"id": idu},
      headers: {},
    ).then((value) {});
  }

  Future<void> unparticipe(idev, idu) async {
    await http.patch(
      Uri.parse("$x/evenement/unparticipe/$idev"),
      body: {"id": idu},
      headers: {},
    ).then((value) {});
  }

  Future<void> likepost(idpub, idu) async {
    await http.patch(
      Uri.parse("$x/user/publication/likepost/$idpub"),
      body: {"id": idu},
      headers: {},
    ).then((value) {});
  }

  Future<void> unlikepost(idpub, idu) async {
    await http.patch(
      Uri.parse("$x/user/publication/unlikepost/$idpub"),
      body: {"id": idu},
      headers: {},
    ).then((value) {});
  }

/* Future<void> updateCurrentUserInformation(id) async {
    const String url = "http://10.0.2.2:8000/users/current/";
    await http.patch(
      url,
      body: {
        "first_name": newTeacher.first_name,
        "profile": json.encode(newTeacher.yourMap) //HOW DO I SHOULD SEND A MAP TO UPDATE LOCATION AND PROFESSION?
      },
      headers: {"Authorization": "JWT $authToken"},
    ).then((value) {
      print(authToken);
      print(value.body);
    });
  }
 */

  Future<List<Class>> fetchClass() async {
    var response = await http.get(Uri.parse('$x/classe'), headers: {
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Credentials": 'true',
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      Map evenementData = jsonDecode(response.body);
      List<dynamic> evenements = evenementData['response'];
      return evenements.map((json) => Class.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future<Class> fetchoneClass(id) async {
    var response = await http.get(Uri.parse('$x/classe/$id'), headers: {
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Credentials": 'true',
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      Map cData = jsonDecode(response.body);
      dynamic classe = cData['response'];
      return classe.map((json) => Class.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future<List<Evenement>> fetchEvenement() async {
    var response = await http.get(Uri.parse('$x/evenement'), headers: {
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Credentials": 'true',
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      Map evenementData = jsonDecode(response.body);
      List<dynamic> evenements = evenementData['response'];
      return evenements.map((json) => Evenement.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future<List<Formation>> fetchFormation() async {
    var response = await http.get(Uri.parse('$x/formation'), headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": 'true',
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      Map formationData = jsonDecode(response.body);
      List<dynamic> formations = formationData['response'];
      return formations.map((json) => Formation.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future<List<Publiucation>> fetchPubliucation() async {
    var response = await http.get(Uri.parse('$x/user/publication'), headers: {
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Credentials": 'true',
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      Map publiucationData = jsonDecode(response.body);
      List<dynamic> publiucations = (publiucationData['response'] as List);
      return publiucations.map((json) => Publiucation.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future<Publiucation> fetchPubliucationid(String id) async {
    var response =
        await http.get(Uri.parse('$x/user/publication/$id'), headers: {
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Credentials": 'true',
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      //Map publiucationData = json.decode(response.body);
      // Publiucation publiucations = (jsonDecode(response.body)['response']);
      return Publiucation.fromJson(jsonDecode(response.body)['response']);
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }

  Future<void> updateuser(
      context, String idu, String nom, String prenom, File? image) async {
    Dio dio = Dio();
    if (image == null) {
      try {
        FormData formData = FormData.fromMap({
          "nom": nom,
          "prenom": prenom,
        });
        Response response = await dio.put("$x/profil/$idu",
            data: formData,
            options: Options(headers: {
              "accept": "*/*",
              "Authorization": "Bearer accresstoken",
              "Content-Type": "multipart/form-data",
            }));
        // Provider.of<MyProvider>(context, listen: false).updateUser(nom, prenom);
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

        Response response = await dio.put("$x/profil/$idu",
            data: formData,
            options: Options(headers: {
              "accept": "*/*",
              "Authorization": "Bearer accresstoken",
              "Content-Type": "multipart/form-data",
            }));
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> ajouterCours(String idu, String idclass, File pdf) async {
    Dio dio = Dio();

    try {
      String filename = pdf.path.split('/').last;
      FormData formData = FormData.fromMap({
        "classe": idclass,
        "user": idu,
        "content": await MultipartFile.fromFile(pdf.path,
            filename: filename, contentType: MediaType('pdf', 'pdf')),
        "type": "file/pdf"
      });
      Response response = await dio.post("$x/classe/cour",
          data: formData,
          options: Options(headers: {
            "accept": "*/*",
            "Authorization": "Bearer accresstoken",
            "Content-Type": "multipart/form-data",
          }));
    } catch (e) {
      print(e);
    }
  }

  Future<void> createPub(
      String idu, String nom, String content, String titre, File? image) async {
    Dio dio = Dio();
    if (image == null) {
      try {
        FormData formData = FormData.fromMap({
          "nom": nom,
          "titre": titre,
          "content": content,
          "user": idu,
        });
        Response response = await dio.post("$x/user/publication/",
            data: formData,
            options: Options(headers: {
              "accept": "*/*",
              "Authorization": "Bearer accresstoken",
              "Content-Type": "multipart/form-data",
            }));
      } catch (e) {
        print(e);
      }
    } else {
      try {
        String filename = image.path.split('/').last;
        FormData formData = FormData.fromMap({
          "nom": nom,
          "titre": titre,
          "content": content,
          "user": idu,
          "img": await MultipartFile.fromFile(image.path,
              filename: filename, contentType: MediaType('image', 'png')),
          "type": "image/png"
        });
        Response response = await dio.post("$x/user/publication/",
            data: formData,
            options: Options(headers: {
              "accept": "*/*",
              "Authorization": "Bearer accresstoken",
              "Content-Type": "multipart/form-data",
            }));
      } catch (e) {
        print(e);
      }
    }
  }

  Future<Publiucation> createPublication(
      String idu, String nom, String content, String titre, String? img) async {
    var req = jsonEncode(<String, dynamic>{
      'user': idu,
      'titre': titre,
      'nom': nom,
      'content': content,
      'img': img
    });

    var contentlength = req.length;
    final response = await http.post(Uri.parse('$x/user/publication'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'keep-alive': 'timeout=50000',
          'Content-Length': '${req.length}'
        },
        body: req);
    if (response.statusCode == 200) {
      return Publiucation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Publication .');
    }
  }

  Future<http.Response> deletePublication(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$x/user/publication/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  Future<http.Response> updatePublication(
      String id, String content, String titre) {
    return http.put(
      Uri.parse('$x/user/publication/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'content': content,
        'titre': titre,
      }),
    );
  }

  Future<void> updatePublicationid(
      String id, String content, String titre) async {
    Dio dio = Dio();

    try {
      FormData formData =
          FormData.fromMap({"content": content, "titre": titre});

      Response response = await dio.put("$x/user/publication/$id",
          data: formData,
          options: Options(headers: {
            "accept": "*/*",
            "Authorization": "Bearer accresstoken",
            "Content-Type": "multipart/form-data",
          }));
    } catch (e) {
      print(e);
    }
  }

  Future<http.Response> updateuserr(
      String idu, String nom, String prenom, File? image) async {
    String filename = image!.path.split('/').last;
    return http.put(
      Uri.parse('$x/user/publication/$idu'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nom': nom,
        'prenom': prenom,
        "img": await MultipartFile.fromFile(image.path,
            filename: filename, contentType: MediaType('image', 'png')),
      }),
    );
  }

  Future<http.Response> updatePublicationLike(String id, List like) {
    return http.put(
      Uri.parse('$x/user/publication/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'likers': like}),
    );
  }

  Future<http.Response> updateEvenementparticipant(
      String id, List participant) {
    return http.put(
      Uri.parse('$x/user/publication/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'participant': participant}),
    );
  }

  static Future<List<Publiucation>> getPubs(String query) async {
    var response = await http.get(Uri.parse('$x/user/publication'), headers: {
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Credentials": 'true',
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });

    if (response.statusCode == 200) {
      final List pubs = json.decode(response.body)['response'];

      return pubs.map((json) => Publiucation.fromJson(json)).where((pub) {
        final titleLower = pub.titre!.toLowerCase();
        final contentLower = pub.content!.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            contentLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
  //CREATE FUNCITON TO CALL LOGIN POST API
}
