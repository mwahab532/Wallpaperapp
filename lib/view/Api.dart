import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class apidarthome extends StatefulWidget {
  const apidarthome({super.key});

  @override
  State<apidarthome> createState() => _apidartState();
}

class _apidartState extends State<apidarthome> {
  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Connection",
      titleColor: Colors.white,
      text: "Somthing went worng!\nPlease cheak your connection and try again",
      textColor: Colors.red,
      backgroundColor: Colors.black,
      confirmBtnColor: Colors.white,
      confirmBtnTextStyle: TextStyle(color: Colors.black),
    );
  }

  var urldata;
  late bool _isloading;
  Future getApi() async {
    try {
      http.Response response;
      response = await http.get(
        Uri.parse(
            "https://api.unsplash.com/photos/?per_page=29&client_id=xHhfG8fBdbRB2A_2Ub6XQ9o2RBrz-4m6AT3fl7RUNdU"),
      );
      if (response.statusCode == 200) {
        setState(
          () {
            urldata = jsonDecode(response.body);
          },
        );
      }
    } catch (e) {
      setState(() {
        showAlert();
      });
    }
  }

  @override
  void initState() {
    _isloading = true;
    Future.delayed(Duration(seconds: 8), () {
      setState(() {
        _isloading = false;
      });
    });
    getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: () async {
        await Future.delayed(
          Duration(seconds: 2),
        );
        setState(() {
          getApi();
        });
      },
      child: SafeArea(
        top: true,
        child: Scaffold(
          body: _isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : GridView.builder(
                  itemCount: 100,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => imagefullview(
                              url: urldata[index]["urls"]["full"],
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: "full",
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(urldata[index]["urls"]["full"]),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class imagefullview extends StatelessWidget {
  var url;
  imagefullview({this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: "full",
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(url), fit: BoxFit.fitHeight),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  splashRadius: 100,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        offset: Offset(1.8, 1.6),
                        color: Colors.black,
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
