import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:clients/GUI/firstpage.dart';
import 'package:clients/GUI/login.dart';
import 'package:clients/GUI/lesMessage.dart';
import 'package:clients/functions/GlobalState.dart';
import 'dart:async' ;
import 'dart:convert';
import 'package:http/http.dart' as http;

class Message extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessageState();
  }


}
class MessageState  extends State<Message> {
  final TextEditingController __userController = new TextEditingController();
  final TextEditingController __passwordController = new TextEditingController();
  final TextEditingController __dateemissionController = new TextEditingController();
  final TextEditingController __Message = new TextEditingController();
  double montant ;
  DateTime dateem;
  GlobalState _store = GlobalState.instance;
  // ignore: non_constant_identifier_names

  void postData() async {
    var myurl = "http://192.168.1.102/laravelp/public/api/messages/sendmessage";
    http.Response response = await http.post(myurl,
        headers: {
      "Accept" : "application/json"
    },body: {
          "id_client": "${_store.get("id_client")}" ,
          "post": "manager",
          "email": "${_store.get("cust_email")}",
          "whoishe": "clients",
          "message": "${__Message.text}",
          "user_id" : "0",
        // ignore: missing_return
        }).then((response){
            debugPrint('Response status ${response.statusCode}');
            debugPrint('Response body : ${response.body}');
            debugPrint('id : ${_store.get("id_client")} email : ${ _store.get("cust_email")}');
    });
    //return json.decode(response.body);
  }
  void _sendMEss(){
    setState(() {
      if(__Message.text.trim().isEmpty == false) {
        postData();
        _neverSatisfied('demande réussie ','réussie');
      }
      else
      if(__userController.text.trim().isEmpty == true )
      { _neverSatisfied('Votre message est vide','les erreurs');}

    });
  }
  void _onClear(){
    setState(() {
      __Message.clear();
    });
  }
  Future<void> _neverSatisfied(String test , String titl ) async {
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$titl'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$test'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                _onClear();
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
          title: new Center( child: new Text('envoyez votre message'))
      ),
      body: new Container(
        alignment:Alignment.center,
        child: new ListView(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top:3.2)),
            new Image.asset('img/messa.png',
              height: 150.0,
              width: 230.0,
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
            ),
           
          new Text("Écrivez votre message",
          textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.3,
              fontStyle: FontStyle.italic,
            ),

          ),
            new TextField(
              maxLength: 250,
              keyboardType:TextInputType.multiline,
              style: TextStyle(fontSize: 19.5 ,
                color: Colors.indigo,
              ),

              controller: __Message,
              obscureText: false,
              maxLines: 6,
              //cursorColor: Colors.indigo,
              decoration: InputDecoration(
                icon:  new Icon(Icons.message,color: Colors.indigo, ) ,
                hintText: 'message',
                labelText:'Message' ,
              ),
            ),

            new Padding(
              padding: EdgeInsets.all(19.5),
            ),
            new Center(
              child: new Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(left: 80.0),
                    child: new FlatButton(
                      color: Colors.indigo,
                      textColor: Colors.white,
                      onPressed:_sendMEss,
                      child: new Text('envoyer mon message'),

                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 50.0),
                    child: new FlatButton(
                      color: Colors.indigoAccent,
                      textColor: Colors.white,
                      onPressed: _onClear ,
                      child: new Text('vider '),

                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      drawer: new Drawer(

        child: new Container(

          color: Colors.blue,
          child: ListView(
            children: <Widget>[
              new Image.asset('img/usersss.png',
                height: 150.0,
                width: 230.0,
                color: Colors.white,
              ),
              new Padding(padding: EdgeInsets.only(top: 9.5)),
              new Container(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(left: 10.0)),
                    new RaisedButton(child: new Row(
                      children: <Widget>[
                        new Icon(Icons.home),
                        new Padding(padding: EdgeInsets.only(left: 10.0)),
                        new Text("accueil",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                      onPressed:() => Navigator.of(context).pushNamed('/First'),

                    ),
                    new RaisedButton(child: new Row(
                      children: <Widget>[
                        new Icon(Icons.person_pin),
                        new Padding(padding: EdgeInsets.only(left: 10.0)),
                        new Text("Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                      onPressed:() => Navigator.of(context).pushNamed('/Profile'),
                    ),
                    new RaisedButton(
                      color: Colors.cyanAccent,
                      child: new Row(
                      children: <Widget>[
                        new Icon(Icons.email),
                        new Padding(padding: EdgeInsets.only(left: 10.0)),
                        new Text("Message",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                      onPressed:() => Navigator.of(context).pushNamed('/sendMessage'),
                    ),

                    new RaisedButton(child: new Row(
                      children: <Widget>[
                        new Icon(Icons.list),
                        new Padding(padding: EdgeInsets.only(left: 10.0)),
                        new Text("les messages",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                      onPressed:() => Navigator.of(context).pushNamed('/ListCheq'),
                    ),

                    new RaisedButton(child: new Row(
                      children: <Widget>[
                        new Icon(Icons.phonelink_erase,color: Colors.red,),
                        new Padding(padding: EdgeInsets.only(left: 10.0)),
                        new Text("Se déconnecter",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                      ],
                    ),
                      onPressed:() => {
                        _store. set ("id_client", ""),
                        _store. set ("cust_f_name", "" ),
                        _store. set ("cust_l_name", ""),
                        _store. set ("cust_email", ""),
                        _store. set ("cust_phone","" ),
                        _store. set ("cust_status", ""),
                        _store. set ("cust_adress", ""),
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/Login", (Route<dynamic> route) => false)
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Colors.red,
        items:[
          new BottomNavigationBarItem(icon: new Icon(Icons.home),
            title: new Text("accueil"),backgroundColor: Colors.red,
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.email),
            title: new Text("message"),
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.person_pin),
            title: new Text("profile"),
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.list),
            title: new Text("les messages"),
          ),
        ],
        onTap: (int index)=>{
          if(index == 0){
            Navigator.of(context).pushNamedAndRemoveUntil('/First', (Route<dynamic> route) => false),}
          else
            if(index == 1){
              Navigator.of(context).pushNamedAndRemoveUntil('/sendMessage', (Route<dynamic> route) => false),}
            else if(index == 2){
              Navigator.of(context).pushNamedAndRemoveUntil('/Profile', (Route<dynamic> route) => false),
            }
            else if(index == 3){
                Navigator.of(context).pushNamedAndRemoveUntil('/ListCheq', (Route<dynamic> route) => false),
              }

        },


      ),
    );
  }
}
