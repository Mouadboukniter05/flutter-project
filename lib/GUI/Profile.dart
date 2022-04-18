import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:clients/GUI/firstpage.dart';
import 'package:clients/GUI/login.dart';
import 'package:clients/GUI/Message.dart';
import 'package:clients/GUI/lesMessage.dart';
import 'package:clients/functions/GlobalState.dart';
class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }


}
class ProfileState  extends State<Profile> {
  final TextEditingController __userController = new TextEditingController();
  final TextEditingController __passwordController = new TextEditingController();
  final TextEditingController __dateemissionController = new TextEditingController();
  double montant ;
  DateTime dateem;
  // ignore: non_constant_identifier_names
  GlobalState _store = GlobalState.instance;

  Future<void> _neverSatisfied(String test ) async {
    return showDialog<void>(
      context:  context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('les erreurs'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Vous oubliez votre $test'),
                Text(' il n\'est jamais satisfait.'),
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
          title: new Center( child: new Text('votre profil'))
      ),
      body: new Container(
        alignment:Alignment.center,
        child: new ListView(
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(9.2)),
            new Image.asset('img/user.png',
              height: 150.0,
              width: 230.0,
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
            ),
            new Center(
              child: new Text("vos informations: ",
                textAlign: TextAlign.center,
              style: TextStyle(
               fontSize: 30.0,
                  fontStyle: FontStyle.italic,
              ),
            ),
            ),
            new Padding(
              padding:EdgeInsets.only(top: 10.0),
            ),
            new Center(
              child:  new Row(
                children: <Widget>[
                  new Padding(
                    padding:EdgeInsets.only(left: 20.0),
                  ),
                  new Icon(Icons.person),
                  new Text("votre prénom est:",style: TextStyle(fontSize: 20.0)),
                  new Text("${_store.get("cust_f_name")}",style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            new Padding(
              padding:EdgeInsets.only(top: 10.0),
            ),
            new Center(
              child:  new Row(
              children: <Widget>[
                new Padding(
                  padding:EdgeInsets.only(left: 20.0),
                ),
                new Icon(Icons.people),
                new Text("votre nom de famille est:",style: TextStyle(fontSize: 20.0),),
                new Padding(padding:EdgeInsets.only(top: 10.0),),
                new Text("${_store.get("cust_l_name")}",style: TextStyle(fontSize: 20.0),),
              ],
            ),
            ),
            new Padding(
              padding:EdgeInsets.only(top: 10.0),
            ),
            new Center(
              child:  new Row(
                children: <Widget>[
                  new Padding(
                    padding:EdgeInsets.only(left: 20.0),
                  ),
                  new Icon(Icons.email),
                  new Text("votre email est:",style: TextStyle(fontSize: 20.0),),
                  new Padding(
                    padding:EdgeInsets.only(left: 10.0),
                  ),
                ],
              ),
            ),

            new Padding(padding:EdgeInsets.only(top: 10.0),),
            new Text("${_store.get("cust_email")}",style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
            new Padding(padding:EdgeInsets.only(top: 10.0),),
            new Center(
              child:  new Row(
                children: <Widget>[
                  new Padding(
                    padding:EdgeInsets.only(left: 20.0),
                  ),
                  new Icon(Icons.phone),
                  new Text("votre téléphone est:",style: TextStyle(fontSize: 20.0),),
                  new Padding(
                    padding:EdgeInsets.only(left: 10.0),
                  ),
                  new Text(" ${_store.get("cust_phone")}",style: TextStyle(fontSize: 20.0),),
                ],
              ),
            ),
            new Padding(
              padding:EdgeInsets.only(top: 10.0),
            ),
            new Center(
              child:  new Row(
                children: <Widget>[
                  new Padding(
                    padding:EdgeInsets.only(left: 20.0),
                  ),
                  new Icon(Icons.share),
                  new Text("votre statut est:",style: TextStyle(fontSize: 20.0),),
                  new Padding(
                    padding:EdgeInsets.only(left: 10.0),
                  ),//TextStyle(fontSize: 20.0extStyle(fontSize: 20.0
                ],
              ),
            ),

            new Padding(padding:EdgeInsets.only(top: 10.0),),
            new Text("${_store.get("cust_status")}",style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
            new Padding(padding:EdgeInsets.only(top: 10.0),),

            new Center(
              child:  new Row(
                children: <Widget>[
                  new Padding(
                    padding:EdgeInsets.only(left: 20.0),
                  ),
                  new Icon(Icons.location_on),
                  new Text("votre adresse est: ",style: TextStyle(fontSize: 20.0,),),
                  new Padding(
                    padding:EdgeInsets.only(left: 5.0),
                  ),
                  new Text( "${_store.get("cust_adress")}",style: TextStyle(fontSize: 20.0,),),
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
            ),
            new Center(),
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
                    new RaisedButton(
                      color: Colors.cyanAccent,
                      child: new Row(
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
        backgroundColor: Colors.indigoAccent,
        items:[
          new BottomNavigationBarItem(icon: new Icon(Icons.home),
            title: new Text("accueil"),backgroundColor: Colors.red,
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.email),
            title: new Text("message"),backgroundColor: Colors.white,
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.person_pin),
            title: new Text("profile"),backgroundColor: Colors.red,
          ),
          new BottomNavigationBarItem(icon: new Icon(Icons.list),
            title: new Text("les messages"),backgroundColor: Colors.white,
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
