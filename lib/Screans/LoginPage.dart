// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/myprovider.dart';
import '../Routes.dart';
import 'this/morphisme.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final passController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: GlassMorphisme(
            blur: 100,
            opacity: 0.4,
            child: SizedBox(
              width: double.infinity - 20,
              height: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email_rounded),
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.password_rounded),
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        login(emailController.text, passController.text);
                      },
                      icon: const Icon(
                        Icons.login,
                        size: 18,
                      ),
                      label: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(String email, String password) async {
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response =
          await http.post(Uri.parse("http://192.168.1.19:8888/login"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({'email': email, 'password': password}));
      var id = jsonDecode(response.body)["user"];
      if (response.statusCode == 200) {
        context.read<MyProvider>().id = id['_id'];
        context.read<MyProvider>().nom = id['nom'];
        context.read<MyProvider>().prenom = id['prenom'];
        context.read<MyProvider>().email = id['email'];
        context.read<MyProvider>().role = id['role'];
        context.read<MyProvider>().password = id['password'];
        Navigator.of(context).pushNamed(RouteManager.newpage);
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
