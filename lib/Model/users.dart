import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String? userId;
  String? email;
  String? userName;
  String? photoURL;
  String? phone;
  String? address;
  String? gender;
  double? coins;

  Users({this.userId, this.email, this.userName, this.photoURL,
    this.phone, this.address, this.gender, this.coins});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'userName': userName,
      'photoURL': photoURL,
      'phone': phone,
      'address': address,
      'gender': gender,
      'coins': coins,
    };
  }

  Users.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : userId = doc.id,
        email = doc.data()!["email"],
        userName = doc.data()!["userName"],
        photoURL = doc.data()!["photoURL"],
        phone = doc.data()!["phone"],
        address = doc.data()!["address"],
        gender = doc.data()!["gender"],
        coins = doc.data()!["coins"];


  Users.fromMap(Map<String, dynamic> userMap)
      : userId = userMap["userId"],
        email = userMap["email"],
        userName = userMap["userName"],
        photoURL = userMap["photoURL"],
        phone = userMap["phone"],
        address = userMap["address"],
        gender = userMap["gender"],
        coins = userMap["coins"];
}

//user name: admin@gmail.com
//password: admin123