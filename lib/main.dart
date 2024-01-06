import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallpaperapp/auth/Authpage.dart';
import 'firebase_options.dart';

void main() async {
  RenderErrorBox.backgroundColor = Colors.white;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  details.exception.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.transparent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  };

  runApp(wallpapers());
}

class wallpapers extends StatelessWidget {
  const wallpapers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wallpapers",
      home: Authpage(),
    );
  }
}
