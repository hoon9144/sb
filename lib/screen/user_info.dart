import 'package:flutter/material.dart';
import 'package:flutterfuturelistviewapp/model/user.dart';

class UserInfo extends StatelessWidget {

  var user;
  UserInfo({this.user});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('info data'),
      ),body: BodyBody(user,context)
    );
  }
}






Widget BodyBody(User user , BuildContext context){
  return Column(
    children: <Widget>[
      Container(
        child: Center(
          child: Text('${user.uid}'),
        ),
      ),
      Container(
        child: Center(
          child: Text('${user.uemail}'),
        ),
      ),
      Container(
        child: Center(
          child: Text('${user.uname}'),
        ),
      ),
      Container(
        child: Center(
          child: Text('${user.uage}'),
        ),
      ),
      RaisedButton(
        color: Colors.deepOrange,
        child: Icon(Icons.backspace),
        onPressed: (){
          Navigator.pop(context);
        },
      )
    ],
  );
}