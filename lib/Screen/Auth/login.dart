import 'package:baucua/Authentication/Authentication.dart';
import 'package:baucua/Core/FadeAnimation.dart';
import 'package:baucua/Core/HexColor.dart';
import 'package:baucua/Screen/Auth/register.dart';
import 'package:baucua/Screen/Home.dart';
import 'package:flutter/material.dart';

enum FormData {
  Email,
  password,
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  Authentication _authService = Authentication();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
            image: const NetworkImage(
              'https://mir-s3-cdn-cf.behance.net/project_modules/fs/01b4bd84253993.5d56acc35e143.jpg',
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  // color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.5,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: (){Navigator.pop(context);},
                                  icon: Icon(Icons.arrow_back)),
                              IconButton(
                                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));},
                                  icon: Icon(Icons.home))
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
                            child: Column(
                              children: [
                                FadeAnimation(
                                  delay: 0.8,
                                  child: Image.asset('assets/img/logo.png',
                                    width: 150,
                                    height: 100,
                                  ),
                                ),
                                FadeAnimation(
                                  delay: 1,
                                  child: const Text(
                                    "Please sign in to continue",
                                    style: TextStyle(
                                        color: Colors.black, letterSpacing: 0.5),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FadeAnimation(
                                  delay: 1,
                                  child: Container(
                                    width: 300,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: selected == FormData.Email
                                          ? enabled
                                          : backgroundColor,
                                    ),
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: _emailController,
                                      onTap: () {
                                        setState(() {
                                          selected = FormData.Email;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: selected == FormData.Email
                                              ? enabledtxt
                                              : deaible,
                                          size: 20,
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                            color: selected == FormData.Email
                                                ? enabledtxt
                                                : deaible,
                                            fontSize: 12),
                                      ),
                                      textAlignVertical: TextAlignVertical.center,
                                      style: TextStyle(
                                          color: selected == FormData.Email
                                              ? enabledtxt
                                              : deaible,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FadeAnimation(
                                  delay: 1,
                                  child: Container(
                                    width: 300,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                        color: selected == FormData.password
                                            ? enabled
                                            : backgroundColor),
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: _passwordController,
                                      onTap: () {
                                        setState(() {
                                          selected = FormData.password;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.lock_open_outlined,
                                            color: selected == FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: ispasswordev
                                                ? Icon(
                                              Icons.visibility_off,
                                              color: selected == FormData.password
                                                  ? enabledtxt
                                                  : deaible,
                                              size: 20,
                                            )
                                                : Icon(
                                              Icons.visibility,
                                              color: selected == FormData.password
                                                  ? enabledtxt
                                                  : deaible,
                                              size: 20,
                                            ),
                                            onPressed: () => setState(
                                                    () => ispasswordev = !ispasswordev),
                                          ),
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                              color: selected == FormData.password
                                                  ? enabledtxt
                                                  : deaible,
                                              fontSize: 12)),
                                      obscureText: ispasswordev,
                                      textAlignVertical: TextAlignVertical.center,
                                      style: TextStyle(
                                          color: selected == FormData.password
                                              ? enabledtxt
                                              : deaible,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FadeAnimation(
                                  delay: 1,
                                  child: TextButton(
                                      onPressed: () {
                                        _authService
                                            .signIn(
                                            _emailController.text, _passwordController.text)
                                            .then((value) {
                                          // go to home screen
                                          if (value?.getIdToken() != null) {
                                            setState(() {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                              // Navigator.pop(context);
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email or password invalid!')));
                                          }
                                        });
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF2697FF),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14.0, horizontal: 80),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(12.0)))),
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                  delay: 1,
                  child: GestureDetector(
                    onTap: (() {}),
                    child: Text("Can't Login?",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          letterSpacing: 0.5,
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Register();
                          }));
                        },
                        child: Text("Sign Up",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
// Future SignIn() async{
//   await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailController.text.trim(),
//     password: passwordController.text.trim(),
//   );
// }
}