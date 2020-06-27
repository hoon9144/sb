class User{

  final int uid;
  final String uname;
  final int uage;
  final String uemail;
  final String uaddress;
  final String upwd;

  User({this.uid,this.uname,this.uage, this.uemail,this.uaddress,this.upwd});

  factory User.fromJson(Map<String , dynamic> json){
    return User(
        uid: json['uid'] == null ? null : json['uid'],
        uname: json['uname']  == null ? null : json['uname'],
        uage:json['uage']  == null ? null : json['uage'],
        uemail: json['uemail']  == null ? null : json['uemail'],
        uaddress: json['uaddress']  == null ? null : json['uaddress'],
        upwd: json['upwd']  == null ? null : json['upwd']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'uid': uid == null ? null : uid,
        'uname': uname == null ? null : uname,
        'uage': uage == null ? null : uage,
        'uemail': uemail == null ? null : uemail,
        'uaddress': uaddress == null ? null : uaddress,
        'upwd': upwd == null ? null : upwd
      };

}