import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'model/user.dart';
import 'screen/search_page.dart';
import 'screen/user_info.dart';


void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {

  Future getUser() async {
    var res = await http.get('http://172.20.10.5:3000/user');
    List<User> parseUser = jsonDecode(res.body)
        .map<User>((json) => User.fromJson(json))
        .toList();
    print(parseUser[0].uemail);
    return parseUser;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('유저 정보'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
          })
        ],
      ),
      body: FutureBuilder(
          future: getUser(),
          builder: (context , snapshot){
            if(snapshot.hasData){
              var user = snapshot.data;
              return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context , index){
                return ListTile(
                  title: Text('${user[index].uemail}'),
                  subtitle: Text('${user[index].uname}'),
                  leading: Text('${user[index].uid}'),
                  trailing: IconButton(icon: Icon(Icons.add), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo(user: user[index],)));
                  }),
                );
              });
            }else if(snapshot.hasError){
              return Center(
                child: Text('ERR ${snapshot.error}'),
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
      }),
    );
  }
}
