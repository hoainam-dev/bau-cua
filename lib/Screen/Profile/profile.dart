import 'package:baucua/Authentication/Authentication.dart';
import 'package:baucua/Core/FadeAnimation.dart';
import 'package:baucua/Model/users.dart';
import 'package:baucua/Screen/Auth/login_google.dart';
import 'package:baucua/Screen/Home.dart';
import 'package:baucua/Service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final User? user = FirebaseAuth.instance.currentUser;
  Users? _user = Users();

  void getUser() async{
    final UserService _userService = UserService();
    await _userService.getUserByEmail(user!.email.toString());
    _user = _userService.user;
  }

  //Init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return getBody(user: _user,
            inforWidget: Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(_user!.photoURL != null
                            ? _user!.photoURL.toString()
                            : "https://i.pinimg.com/564x/69/ed/a6/69eda630979ffd1a1259bed45c5f5df5.jpg"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${user!.email}",),
                  ],
                )
              ]),),
          );
        } else {
          return getBody(user: _user,
            inforWidget: Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              LoginWithGoogle()))
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white)),
                    child: Column(
                      children: [
                        Text("Đăng nhập", style: TextStyle(color: Colors.black))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }
    );
  }
}

class getBody extends StatefulWidget {
  const getBody({Key? key, required this.inforWidget, required this.user}) : super(key: key);
  final Widget inforWidget;
  final Users? user;

  @override
  State<getBody> createState() => _getBodyState();
}

class _getBodyState extends State<getBody> {

  void confirmLogout(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Xác nhận đăng xuất'),
            actions: [
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('HỦY', style: TextStyle(color: Colors.green),)),
              // The "Yes" button
              TextButton(
                  onPressed: () async{
                    await Authentication.signOut(context: context);
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('XÁC NHẬN', style: TextStyle(color: Colors.green),)),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: FadeAnimation(
                      delay: 0.1,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));},
                              icon: Icon(Icons.home))
                        ],
                      ),
                    ),
                  ),
                  widget.inforWidget,
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(260, 30),
                          topRight: Radius.elliptical(260, 30)),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            ProfileMenuWidget(
                              onPress: () => {},
                              title: "Lưu",
                              icon: Icons.save,
                              Iconcolor: Colors.red,
                            ),
                            ProfileMenuWidget(
                              onPress: () => {},
                              title: "Lịch sử",
                              icon: Icons.query_builder_sharp,
                              Iconcolor: Colors.yellow,
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                        Column(
                          children: [
                            ProfileMenuWidget(
                              onPress: () => {},
                              title: "Tôi muốn phản hồi",
                              icon: Icons.quiz,
                            ),
                            ProfileMenuWidget(
                              onPress: () =>
                              {
                                confirmLogout(context)
                              },
                              title: "Đăng xuất",
                              icon: Icons.logout,
                              textColor: Colors.red,
                              endIcon: false,
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
  Widget infoText(String text){
    return Text(text,style: TextStyle(color: Colors.grey, fontSize: 13));
  }
  Widget titleInfoText(String text){
    return Text(text);
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    this.Iconcolor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final Color? Iconcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            icon,
            color: Iconcolor,
            size: 25,
          ),
        ),
        title: Text(this.title,
            style: TextStyle(fontSize: 15)
        ));
  }
}

