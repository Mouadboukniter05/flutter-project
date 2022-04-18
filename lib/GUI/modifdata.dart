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
class Update extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new UpdateState();
  }

}
class UpdateState extends State<Update>{
  final TextEditingController __cust_emailController = new TextEditingController();
  final TextEditingController __phoneController = new TextEditingController();
  final TextEditingController __cust_f_nameController = new TextEditingController();
  final TextEditingController __cust_l_nameController = new TextEditingController();
  final TextEditingController __cust_statusController = new TextEditingController();
  final TextEditingController __cust_adressController = new TextEditingController();

  String name ;
  GlobalState _store = GlobalState.instance;


  @override
  void initState(){
    __cust_emailController.text = _store.get('cust_email');
     __phoneController.text = _store.get('cust_phone');
     __cust_statusController.text = _store.get('cust_status');
     __cust_adressController.text = _store.get('cust_adress');

  }


  Future<void> _neverSatisfied(String test ) async {
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('successfully'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$test'),
                Text(' successfully'),
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
            title: new Center( child: new Text('update'))
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
                controller: __cust_emailController,
                decoration: InputDecoration(
                  icon:  new Icon(Icons.person , color: Colors.indigo,),
                  hintText: 'azt@email.com',
                  labelText:'Your new email' ,
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(5.0),
              ),
              new TextField(
                style: TextStyle(fontSize: 19.5 ,
                  color: Colors.indigo,
                ),
                controller: __phoneController,
                //cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  icon:  new Icon(Icons.phone,color: Colors.indigo, ) ,
                  hintText: '06XXXXXXXX',
                  labelText:'your number phone',
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(5.0),
              ),
              new TextField(
                style: TextStyle(fontSize: 19.5 ,
                  color: Colors.indigo,
                ),
                controller: __cust_statusController,
                //obscureText: true,
                //cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  icon:  new Icon(Icons.share,color: Colors.indigo, ) ,
                  hintText: 'new  SATUTS',
                  labelText:'new  SATUTS' ,
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(5.0),
              ),
              new TextField(
                style: TextStyle(fontSize: 19.5 ,
                  color: Colors.indigo,
                ),
                controller: __cust_adressController,
                //obscureText: true,
                //cursorColor: Colors.indigo,
                decoration: InputDecoration(
                  icon:  new Icon(Icons.add_location,color: Colors.indigo, ) ,
                  hintText: 'new addresse',
                  labelText:'new addresse' ,
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(10.0),
              ),
              new Center(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 80.0),
                      child: new FlatButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        onPressed:_onpresse,
                        child: new Text('Update'),
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
  void putData() async {
    var id =_store.get("id_client");
    var myurl = "http://192.168.1.102/laravelp/public/api/clients/update/$id";
    http.Response response = await http.put(myurl,
        headers: {
      "Accept" : "application/json"
    },body: {
          "cust_status": __cust_statusController.text,
          "cust_adress": __cust_emailController.text,
          "cust_phone": __phoneController.text,
          "cust_email": __cust_emailController.text ,
          // ignore: missing_return
        }).then((response) {
      debugPrint('Response status ${response.statusCode}');
      debugPrint('Response body : ${response.body}');
    });
    //return json.decode(response.body);


  }

        Future<List> getDataid() async {
          var id =_store.get("id_client");
          var myurl = "http://192.168.1.102/laravelp/public/api/clients/$id";
          http.Response response = await http.get(myurl,headers: {"Accept" : "application/json"});
          return json.decode(response.body);
        }

          void _onpresse() async{
            putData();
            _neverSatisfied("update is done");
            List data = await(this.getDataid());
            int i = data.length;
            setState(() {
              _store.set("id_client", data[i-1]["id"]);
              _store.set("cust_f_name", data[i-1]["cust_f_name"]);
              _store.set("cust_l_name", data[i-1]["cust_l_name"]);
              _store.set("cust_email", data[i-1]["cust_email"]);
              _store.set("cust_phone", data[i-1]["cust_phone"]);
              _store.set("cust_status", data[i-1]["cust_status"]);
              _store.set("cust_adress", data[i-1]["cust_adress"]);
              Navigator.of(context).pushNamed('/Profile');
            });
          }
        }







