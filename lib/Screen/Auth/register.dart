import 'package:baucua/Authentication/Authentication.dart';
import 'package:baucua/Screen/Home.dart';
import 'package:baucua/Service/user_service.dart';
import 'package:flutter/material.dart';

import 'package:baucua/Core/FadeAnimation.dart';
import 'package:baucua/Core/HexColor.dart';
import 'login.dart';

enum FormData { Name, Phone, Email, Gender, password, ConfirmPassword }

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;

  FormData? selected;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _photoURLController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Authentication _authService = Authentication();

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
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back)),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  },
                                  icon: Icon(Icons.home))
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              FadeAnimation(
                                delay: 0.8,
                                child: Image.asset(
                                  'assets/img/logo.png',
                                  width: 200,
                                  height: 100,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FadeAnimation(
                                delay: 1,
                                child: Container(
                                  child: Text(
                                    "Create your account",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.9),
                                        letterSpacing: 0.5),
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
                                    color: selected == FormData.Email
                                        ? enabled
                                        : backgroundColor,
                                  ),
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: _nameController,
                                    onTap: () {
                                      setState(() {
                                        selected = FormData.Name;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.title,
                                        color: selected == FormData.Name
                                            ? enabledtxt
                                            : deaible,
                                        size: 20,
                                      ),
                                      hintText: 'Full Name',
                                      hintStyle: TextStyle(
                                          color: selected == FormData.Name
                                              ? enabledtxt
                                              : deaible,
                                          fontSize: 12),
                                    ),
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                        color: selected == FormData.Name
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
                                    color: selected == FormData.Email
                                        ? enabled
                                        : backgroundColor,
                                  ),
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: _photoURLController,
                                    onTap: () {
                                      setState(() {
                                        selected = FormData.Name;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.title,
                                        color: selected == FormData.Name
                                            ? enabledtxt
                                            : deaible,
                                        size: 20,
                                      ),
                                      hintText: 'Photo URL',
                                      hintStyle: TextStyle(
                                          color: selected == FormData.Name
                                              ? enabledtxt
                                              : deaible,
                                          fontSize: 12),
                                    ),
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                        color: selected == FormData.Name
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
                                            color: selected ==
                                                FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          )
                                              : Icon(
                                            Icons.visibility,
                                            color: selected ==
                                                FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          ),
                                          onPressed: () => setState(() =>
                                          ispasswordev = !ispasswordev),
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
                                child: Container(
                                  width: 300,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color:
                                      selected == FormData.ConfirmPassword
                                          ? enabled
                                          : backgroundColor),
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: _confirmPasswordController,
                                    onTap: () {
                                      setState(() {
                                        selected = FormData.ConfirmPassword;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.lock_open_outlined,
                                          color: selected ==
                                              FormData.ConfirmPassword
                                              ? enabledtxt
                                              : deaible,
                                          size: 20,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: ispasswordev
                                              ? Icon(
                                            Icons.visibility_off,
                                            color: selected ==
                                                FormData
                                                    .ConfirmPassword
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          )
                                              : Icon(
                                            Icons.visibility,
                                            color: selected ==
                                                FormData
                                                    .ConfirmPassword
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          ),
                                          onPressed: () => setState(() =>
                                          ispasswordev = !ispasswordev),
                                        ),
                                        hintText: 'Confirm Password',
                                        hintStyle: TextStyle(
                                            color: selected ==
                                                FormData.ConfirmPassword
                                                ? enabledtxt
                                                : deaible,
                                            fontSize: 12)),
                                    obscureText: ispasswordev,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                        color:
                                        selected == FormData.ConfirmPassword
                                            ? enabledtxt
                                            : deaible,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              FadeAnimation(
                                delay: 1,
                                child: TextButton(
                                    onPressed: () async {
                                      final String name = _nameController.text;
                                      final String photoURL = _photoURLController.text;
                                      final String email = _emailController.text;
                                      final String password = _passwordController.text;
                                      final String confirmpassword = _confirmPasswordController.text;

                                      bool validate = true;
                                      String? message;
                                      final UserService _userService =
                                      UserService();

                                      const pattern =
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

                                      final regExp = RegExp(pattern);

                                      if (name.isEmpty &&
                                          email.isEmpty &&
                                          password.isEmpty &&
                                          confirmpassword.isEmpty) {
                                        setState(() {
                                          validate = false;
                                          message =
                                          "Please enter your information!";
                                        });
                                      } else if (name.isEmpty) {
                                        setState(() {
                                          validate = false;
                                          message =
                                          "You have to enter your name!";
                                        });
                                      } else if (email.isEmpty) {
                                        setState(() {
                                          validate = false;
                                          message =
                                          "You have to enter your email!";
                                        });
                                      } else if (password.isEmpty ||
                                          confirmpassword.isEmpty) {
                                        setState(() {
                                          validate = false;
                                          message =
                                          "You have to enter your password!";
                                        });
                                      } else if (password != confirmpassword) {
                                        validate = false;
                                        setState(() {
                                          validate = false;
                                          message =
                                          "Password not match! Please check again.";
                                        });
                                      } else if (!(password.length > 5) &&
                                          password.isNotEmpty) {
                                        setState(() {
                                          validate = false;
                                          message =
                                          "Password should contain more than 5 characters";
                                        });
                                      } else if (!(regExp.hasMatch(email))) {
                                        setState(() {
                                          validate = false;
                                          message =
                                          "Email not valid! please enter again.";
                                        });
                                      }

                                      if (validate) {
                                        await _userService.getUserByEmail(email);
                                        if (_userService.user == null) {
                                          _authService.createUser(
                                              name, email, password, photoURL);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return Login();
                                                  }));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Create account successfully. Let Login!')));
                                        }else{
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                "email address exist.",
                                                style: TextStyle(color: Colors.red),
                                              )));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: Text(
                                              "${message}",
                                              style: TextStyle(color: Colors.red),
                                            )));
                                      }
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                        const Color(0xFF2697FF),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0, horizontal: 80),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12.0)))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // //End of Center Card
                // //Start of outer card
                const SizedBox(
                  height: 20,
                ),

                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("If you have an account ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        },
                        child: Text("Sign In",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
