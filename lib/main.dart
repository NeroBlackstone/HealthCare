import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());
var flutterLocalNotificationsPlugin;
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData.light(),
      home: LoginPage(),
      routes: <String,WidgetBuilder>{
        '/signUp':(_)=>SignUpPage(),
        '/homePage':(_)=>HomePage(),
      },
    );
  }
}
