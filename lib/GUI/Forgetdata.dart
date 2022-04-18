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
class Foreget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new ForegetState ();
  }

}
class ForegetState extends State<Foreget>{
  final TextEditingController __userController = new TextEditingController();
  String password ;
  GlobalState _store = GlobalState.instance;
void kl() async{
  List data = await(this.getDataid());
  int k = data.length;
  setState(() {
    _store.set("id_client", data[k-1]["id"]);
    _store.set("cust_f_name", data[k-1]["cust_f_name"]);
    _store.set("cust_l_name", data[k-1]["cust_l_name"]);
    _store.set("cust_email", data[k-1]["cust_email"]);
    _store.set("cust_phone", data[k-1]["cust_phone"]);
    _store.set("cust_status", data[k-1]["cust_status"]);
    _store.set("cust_adress", data[k-1]["cust_adress"]);
  });

}
  void _moveon() async{

    setState(() {
      if(password == null ){
        _neverSatisfied('vous devez trouver votre mot de passe pour continuer','les erreurs');
      }
      else {
      Navigator.of(context).pushNamed('/First');
      }
    });
    }

  _onClear(){

  }
//////////////////////////////////////////
  void _findout() async{
    List data = await(this.getData());
    int k = data.length;
    setState(() {
      int m=0;
      if(__userController.text.trim().isEmpty == false) {

        for (int i = 0;i<k;i++) {
          if ( data[i]["cust_email"]  == __userController.text  ) {
            password = 'votre mot de passe est: ${data[i]["cust_phone"]}';
            _store.set("id_client",data[i]["id"]);
            _store.set("cust_f_name",data[i]["cust_f_name"]);
            _store.set("cust_l_name",data[i]["cust_l_name"]);
            _store.set("cust_email",data[i]["cust_email"]);
            _store.set("cust_phone",data[i]["cust_phone"]);
            _store.set("cust_status",data[i]["cust_status"]);
            _store.set("cust_adress",data[i]["cust_adress"]);
            _onClear();
            break;
          }

          debugPrint(' ${data[i]["cust_f_name"] }');
          debugPrint('/////////////////////////////////////////////////');
          debugPrint(' ${data[i]["cust_l_name"]}');
          m++;
        }
        if(m==k) {
          _neverSatisfied('il s\'agit d\'un e-mail qui n\'existe pas   ','les erreurs');
        }
      }
      else
      if(__userController.text.trim().isEmpty == true)
      { _neverSatisfied('écrivez votre email ','les erreurs');}
    });
  }
//////////////////////////////////////////////////////////////////
  Future<void> _neverSatisfied(String test , String TTT ) async {
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('les erreurs'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(' $TTT'),
                Text(' $test'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
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
            title: new Center( child: new Text('vous oubliez votre mot de passe'))
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
                padding: EdgeInsets.all(10.0),
              ),
              new Center(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: new FlatButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        onPressed:_findout,
                        child: new Text('chercher'),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 80.0),
                      child: new FlatButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: _moveon,
                        child: new Text('passez'),
                      ),
                    ),
                  ],
                ),
              ),
              new Text('$password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0,
                  fontStyle: FontStyle.italic,color: Colors.red),
              )
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
  Future<List> getDataid() async {
    var id =_store.get("id_client");
    var myurl = "http://192.168.1.102/laravelp/public/api/clients/$id}";
    http.Response response = await http.get(myurl,headers: {"Accept" : "application/json"});
    return json.decode(response.body);
  }
}





