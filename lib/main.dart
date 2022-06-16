import 'package:alpha/main/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/PublicationProvider.dart';
import 'Provider/myprovider.dart';
import 'Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MyProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DataPublication(),
          ),
        ],
        builder: (context, child) {
          // ignore: prefer_const_constructors
          return MaterialApp(
            theme: ThemeData(
              dividerColor: Colors.black,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: RouteManager.loginPage,
            onGenerateRoute: RouteManager.generateRoute,
          );
        });
  }
}
