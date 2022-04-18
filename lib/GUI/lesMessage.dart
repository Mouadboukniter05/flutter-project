import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clients/GUI/lesMessage.dart';
import 'package:clients/GUI/login.dart';
import 'package:clients/GUI/Message.dart';
import 'package:clients/functions/GlobalState.dart';
class LesMessage extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() {
    return LesMessageState();
  }
}



class LesMessageState extends State<LesMessage>{

  GlobalState _store = GlobalState.instance;
  Future<List> getData() async {
    var id = _store.get("id_client");
    String myurl = "http://192.168.1.102/laravelp/public/api/messages/$id";
    http.Response response = await http.get(myurl,headers: {"Accept" : "application/json"});
    return json.decode(response.body);
  }
  Widget widgetMine() {
    return FutureBuilder(
        future: getData(),
        // ignore: missing_return
        builder:(BuildContext context  ,AsyncSnapshot<List> snapshot)  {
          debugPrint('${snapshot.data}');
          if(snapshot.hasData){
            List content = snapshot.data;
            return new ListView.builder(
              itemCount: content.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  contentPadding: EdgeInsets.only(top: 5.0),
                  title: new Text('de : ${content[index]['email']}',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 25.0,
                    ),
                  ),
                  subtitle: new Text('${content[index]['message']}',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 16.0,
                    ),
                  ),
                  leading: new CircleAvatar(
                    child: new Text('P ${content[index]['whoishe']}'),
                    foregroundColor: Colors.cyan,
                    backgroundColor: Colors.pink,

                  ),
                  onTap: ()=>{ showMoreInfo(context ,' from : ${content[index]['email']} ',' ${content[index]['message']}'), },
                );

              },
            );
          }
          else
          {

            new Container(
                child:
                new Text('attendez, nous avons un problème')
            );
          }
        }


    );
  }
  Future<void> showMoreInfo(context , String title ,String body ) async{
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text( '$body'),
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


  //static List data;
  /*void _onClear(){
    setState(() {
      __userController.clear();
      __passwordController.clear();
    });
  }*/
  /*  void mess(){
    if(data.length==null) {
      _neverSatisfied('plese wait, be patiant', 'getting data');
    }
      }*/

  Future<void> _neverSatisfied(String test,String TIT  ) async {
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TIT),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text( '$test'),
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
    //getData();
    //mess();
    //getDatas();
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.indigo,
          title:  Text("Bonjour",textAlign: TextAlign.center,)
      ),
      body:  new    Center(
        child:widgetMine(),
      ),
      /////////////////////////////////////
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
                    new RaisedButton(
                      child: new Row(
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
                    new RaisedButton(child: new Row(
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

                    new RaisedButton(
                      color: Colors.cyanAccent,
                      child: new Row(
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
        backgroundColor: Colors.indigoAccent,
        items:[
          new BottomNavigationBarItem(icon: new Icon(Icons.home),
            title: new Text("accueil"),backgroundColor: Colors.red,
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.email),
            title: new Text("message"),backgroundColor: Colors.white,
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.person_pin),
            title: new Text("profile"),backgroundColor: Colors.white,
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.list),
            title: new Text("les messages"),backgroundColor: Colors.red,
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
