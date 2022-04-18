// ignore: avoid_web_libraries_in_flutter
import 'dart:async' ;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clients/GUI/lesMessage.dart';
import 'package:clients/GUI/Message.dart';
import 'package:clients/GUI/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:clients/functions/GlobalState.dart';
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new LoginState();
  }

}
class LoginState extends State<Login>{
  final TextEditingController __userController = new TextEditingController();
  final TextEditingController __passwordController = new TextEditingController();
  String name ;
  GlobalState _store = GlobalState.instance;



  @override
  void initState(){
    _store.set("name", name);
    _store.set("user","" );
    __userController.text = _store.get('user');

  }
 void _onLogin() async{
   List data = await(this.getData());
    int k = data.length;
  setState(() {
    int m=0;
    if(__userController.text.trim().isEmpty == false  && __passwordController.text.trim().isEmpty == false ) {

      for (int i = 0;i<k;i++) {
        debugPrint(' ${data[i]["nom"] }');
        if ( data[i]["cust_email"]  == __userController.text &&
            data[i]["cust_phone"] ==__passwordController.text ) {
          _store.set("id_client",data[i]["id"]);
          _store.set("cust_f_name",data[i]["cust_f_name"]);
          _store.set("cust_l_name",data[i]["cust_l_name"]);
          _store.set("cust_email",data[i]["cust_email"]);
          _store.set("cust_phone",data[i]["cust_phone"]);
          _store.set("cust_status",data[i]["cust_status"]);
          _store.set("cust_adress",data[i]["cust_adress"]);
          _onClear();
          Navigator.of(context).pushNamed('/First');
          break;
        }

        debugPrint(' ${data[i]["cust_f_name"] }');
        debugPrint('/////////////////////////////////////////////////');
        debugPrint(' ${data[i]["cust_l_name"]}');
        m++;
      }
      if(m==k) {
        _neverSatisfied('votre password ou email ');
        debugPrint('$data');
      }
    }
    else
      if(__userController.text.trim().isEmpty == true  && __passwordController.text.trim().isEmpty == true)
      {
        debugPrint("hawaaaaa");
        _neverSatisfied('email et password');}
      else
      if(__userController.text.trim().isEmpty == true  && __passwordController.text.trim().isEmpty == false)
      { _neverSatisfied('email');}
      else
      if(__userController.text.trim().isEmpty == false  && __passwordController.text.trim().isEmpty == true)
      { _neverSatisfied('password');}
  });
 }
 void _onClear(){
   setState(() {
     __userController.clear();
     __passwordController.clear();
   });
 }
 void _onBtn(){
   _store.set("user", __userController.text);
   _onLogin();
 }

  Future<void> _neverSatisfied(String test ) async {
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('errors'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(' votre  $test'),
                Text(' ce n\'est jamais satisfait.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.indigo,
        title: new Center( child: new Text('Page de connexion'))
      ),
      body: new Container(

        padding: EdgeInsets.all(19.3),
        alignment:Alignment.center,
        child: new ListView(
          children: <Widget>[
            new Image.asset('img/usersss.png',
            height: 150.0,
              width: 230.0,
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
            ),
                  new TextField(
                    style: new TextStyle(fontSize: 19.5 , color: Colors.indigo,),
                   controller: __userController,
                   decoration: InputDecoration(
                     icon:  new Icon(Icons.person , color: Colors.indigo,),
                     hintText: 'azt@email.com',
                     labelText:'Votre email' ,
                   ),
                  ),
            new Padding(
              padding: EdgeInsets.all(5.0),
            ),
            new TextField(
              style: TextStyle(fontSize: 19.5 ,
                color: Colors.indigo,
              ),
              controller: __passwordController,
              obscureText: true,
              //cursorColor: Colors.indigo,
              decoration: InputDecoration(
                icon:  new Icon(Icons.lock,color: Colors.indigo, ) ,
                hintText: '*******************',
                labelText:'password' ,
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(9.5),
            ),
            new Container(
              child: new FlatButton(
                onPressed: ()=>{
                Navigator.of(context).pushNamed('/forget'),
                },
                child: new Text('si vous avez oublié votre mot de passe, cliquez sur moi',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                  ),

                ),
              ),
            ),

            new Padding(
              padding: EdgeInsets.all(10.0),
            ),
            //lola@gmail.com 0632146578
            new Center(
              child: new Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(left: 80.0),
                    child: new FlatButton(
                      color: Colors.indigo,
                      textColor: Colors.white,
                      onPressed:_onLogin,
                      child: new Text('S\'identifier '),

                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 50.0),
                    child: new FlatButton(
                      color: Colors.indigoAccent,
                      textColor: Colors.white,
                      onPressed:  _onBtn,
                      child: new Text('vider '),

                    ),
                  ),

                ],
              ),
            ),
                ],
              ),
            )
    );
  }
  Future<List> getData() async {
    var myurl = "http://192.168.1.102/laravelp/public/api/clients";
    http.Response response = await http.get(myurl,headers: {"Accept" : "application/json"});
    return json.decode(response.body);
   }
}





