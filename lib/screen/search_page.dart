import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterfuturelistviewapp/model/user.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatelessWidget {
  TextEditingController uid = TextEditingController();

  TextEditingController uemail = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController uage = TextEditingController();
  TextEditingController uaddress = TextEditingController();
  TextEditingController upwd = TextEditingController();

  Future getUser() async {
    var res = await http.get('http://172.20.10.5:3000/user/${uid.text}');
    List<User> parseUser =
        jsonDecode(res.body).map<User>((json) => User.fromJson(json)).toList();
    print(parseUser[0].uname);
    uemail.text = parseUser[0].uemail;
    uname.text = parseUser[0].uname;
    uage.text = '${parseUser[0].uage}';
    uaddress.text = parseUser[0].uaddress;
    upwd.text = parseUser[0].upwd;
    return parseUser;
  }

  void inserUser() async {

    var updateData = {
      "uemail":uemail.text,
      "uname":uname.text,
      "uage":uage.text,
      "uaddress":uaddress.text,
      "upwd":upwd.text
    };

    var res = await http.post('http://172.20.10.5:3000/user/join/' , body: jsonEncode(updateData) ,headers : {'Content-Type': "application/json"});
    print(jsonDecode(res.body));


  }

  void putUser() async {
    var updateData = {
      "uemail":uemail.text,
      "uname":uname.text,
      "uage":uage.text,
      "uaddress":uaddress.text,
      "upwd":upwd.text
    };

    // 숙제! 함께 해결해야할 문제.
    var res = await http.put('http://172.20.10.5:3000/user/update/${uid.text}' ,
        body: jsonEncode(updateData) ,
        headers:  {'Content-Type': "application/json"});
  }


  void deletUser(BuildContext context) async {
    var res = await http.delete('http://172.20.10.5:3000/delete/user/${uid.text}');
    if(res.statusCode == 200){
      print(jsonDecode(res.body));
      Navigator.pop(context);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원정보 조회 및 수정'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'uid enter!',
                    ),
                    controller: uid,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  color: Colors.deepOrange,
                  child: Icon(Icons.search),
                  onPressed: () {
                    getUser();
                  },
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 50),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '${upwd.text}',
                  ),
                  controller: uemail,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '${upwd.text}',
                  ),
                  controller: uname,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '${upwd.text}',
                  ),
                  controller: uaddress,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '${upwd.text}',
                  ),
                  controller: uage,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '${upwd.text}',
                  ),
                  controller: upwd,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    putUser();
                  },
                  child: Text('수정'),
                  color: Colors.amber,
                ),
                FlatButton(
                  onPressed: () {
                    deletUser(context);
                  },
                  child: Text('삭제'),
                  color: Colors.amber,
                ),FlatButton(
                  onPressed: () {
                    inserUser();
                  },
                  child: Text('입력'),
                  color: Colors.amber,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
