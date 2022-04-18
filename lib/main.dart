import 'package:clients/GUI/Forgetdata.dart';
import 'package:flutter/material.dart';
import 'package:clients/GUI/login.dart';
import 'package:clients/GUI/firstpage.dart';
import 'package:flutter/rendering.dart';
import 'package:clients/GUI/lesMessage.dart';
import 'package:clients/GUI/Message.dart';
import 'package:clients/GUI/Profile.dart';
import 'package:clients/GUI/modifdata.dart';
import 'package:clients/GUI/splashscreen.dart';
import 'package:clients/GUI/Forgetdata.dart';
void main() async => runApp(new MaterialApp(
  home: new MyApp(),
));
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "hiraro",
      routes:<String,WidgetBuilder>{
        '/Login' : (BuildContext context) => new Login(),
        '/First' : (BuildContext context) => new First(),
        //'/CreateCheques' : (BuildContext context) => new CreateCheque(),
        '/ListCheq' : (BuildContext context) => new LesMessage(),
        '/sendMessage' : (BuildContext context) => new Message(),
        '/Profile' : (BuildContext context) => new Profile(),
        '/ChangePassword' : (BuildContext context) => new Profile(),
        '/forget' : (BuildContext context) => new Foreget(),
       // '/update' : (BuildContext context) => new Update(),
      },
      home: Splash(),
    );
  }
}



