import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baucua/Model/users.dart';


class UserService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Users> users = [];
  Users? user;

  //get collection user and convert to list
  Future<List<Users>> retrieveUser() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("users").get();
    return snapshot.docs
        .map((docSnapshot) => Users.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  //get all user
  Future<void> getAllUsers() async {
    var retrieveUserList = await retrieveUser();
    retrieveUserList.forEach((element) {
      Users user = Users(
          userId: element.userId,
          email: element.email,
          userName: element.userName,
          photoURL: element.photoURL,
          phone: element.phone,
          address: element.address,
          gender: element.gender,
        coins: element.coins,
      );
      users.add(user);
    });
  }

  //get user
  Future<void> getUserById(String id) async {
    var retrieveUserList = await retrieveUser();
    retrieveUserList.forEach((element) {
      if(id==element.userId){
        user = Users(
            userId: element.userId,
            email: element.email,
            userName: element.userName,
            photoURL: element.photoURL,
            phone: element.phone,
            address: element.address,
            gender: element.gender,
            coins: element.coins,
        );
      }
    });
  }

  Future<void> getUserByEmail(String email) async {
    var retrieveUserList = await retrieveUser();
    retrieveUserList.forEach((element) {
      if(element.email==email){
        user = Users(
            userId: element.userId,
            email: element.email,
            userName: element.userName,
            photoURL: element.photoURL,
            phone: element.phone,
            address: element.address,
            gender: element.gender,
            coins: element.coins,
        );
      }
    });
  }
}