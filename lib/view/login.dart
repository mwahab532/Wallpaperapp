import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:wallpaperapp/view/Register.dart';
import 'package:wallpaperapp/widgets/loginfeilds.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailcontrollar = TextEditingController();

  TextEditingController passwordcontrollar = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<void> showAlert() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Successful",
      titleColor: Colors.green,
      text: "Successsfully Sign In",
      textColor: Colors.green,
      backgroundColor: Colors.black,
      confirmBtnColor: Colors.white,
      confirmBtnTextStyle: TextStyle(color: Colors.black),
      width: 50,
    );
  }

  Future<void> passwordAlert() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      text: "Your Password was worng for this email",
      textColor: Colors.red,
      backgroundColor: Colors.black,
      confirmBtnColor: Colors.white,
      confirmBtnTextStyle: TextStyle(color: Colors.black),
      width: 50,
    );
  }

  Future<void> emailAlert() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      text: "No user found for this email",
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

  signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontrollar.text, password: passwordcontrollar.text)
          .then((value) {
        showAlert();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //Here i am  trying to show popup when error occur but popup is not showing can anyone solve it.
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void dispose() {
    _btnController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1702726694297-791e380c538a?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                  fit: BoxFit.fitHeight,
                ),
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
                        "Sign to ",
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
                            loginfeild(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Email can't be Empty";
                                }
                                return null;
                              },
                              hinttxt: "Email or username",
                              isobscure: false,
                              controller: emailcontrollar,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            loginfeild(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Password can't be Empty";
                                }
                                return null;
                              },
                              hinttxt: "Password",
                              isobscure: true,
                              controller: passwordcontrollar,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RoundedLoadingButton(
                              color: Colors.grey.shade900,
                              controller: _btnController,
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  signInWithEmailAndPassword();
                                }
                              },
                              child: Text(
                                "Login",
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
                                  "Do you want to Sign Up! ",
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
                                        builder: (context) => Register(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
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
