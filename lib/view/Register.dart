import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:wallpaperapp/view/login.dart';
import 'package:wallpaperapp/widgets/Registerfeilds.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _usernamecontrollar = TextEditingController();

  TextEditingController _passwordcontrollar = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<void> showAlert() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Successful",
      text: "Successsfully Sign UP",
      textColor: Colors.green,
      backgroundColor: Colors.black,
      confirmBtnColor: Colors.white,
      confirmBtnTextStyle: TextStyle(color: Colors.black),
      width: 50,
    );
  }

  Future<void> showAlert1() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: "Info",
      text: "The account already exists for that email.",
      textColor: Colors.red,
      backgroundColor: Colors.black,
      confirmBtnColor: Colors.white,
      confirmBtnTextStyle: TextStyle(color: Colors.black),
      width: 50,
    );
  }

  Future<void> errorAlert() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Error",
      text: "Somthing went worng.Please cheak your credentials",
      textColor: Colors.red,
      backgroundColor: Colors.black,
      confirmBtnColor: Colors.white,
      confirmBtnTextStyle: TextStyle(color: Colors.black),
      width: 50,
    );
  }

  createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _usernamecontrollar.text,
        password: _passwordcontrollar.text,
      )
          .then((value) {
        showAlert();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          showAlert1();
        });
      }
    } catch (e) {
      setState(() {
        errorAlert();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1625217945245-dc2a354ee697?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(
                        "Sign Up ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Wallpaper App! ",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Registerfeilds(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Email can't be Empty";
                                }
                                return null;
                              },
                              hinttxt: "Email or username",
                              isobscure: false,
                              controller: _usernamecontrollar,
                              txtsty: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Registerfeilds(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Password can't be Empty";
                                } else if (text.toString().length <= 8) {
                                  return "password must be consist of 8 character";
                                }
                                return null;
                              },
                              hinttxt: "Password",
                              isobscure: true,
                              controller: _passwordcontrollar,
                              txtsty: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RoundedLoadingButton(
                              color: Colors.grey.shade900,
                              controller: _btnController,
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  createUserWithEmailAndPassword();
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already Register! ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign IN",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
