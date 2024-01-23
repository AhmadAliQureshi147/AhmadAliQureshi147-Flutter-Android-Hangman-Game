import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'play.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          fontFamily: 'Lobster',
          fontSize: 30,
          color: Colors.black87,
        ),
        backgroundColor: Colors.purple[100],
        title: const Center(child: Text("The Hangman Game!")),
      ),
      backgroundColor: Colors.deepPurple[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading...',
              style: TextStyle(fontSize: 34, color: Colors.black87, fontFamily: 'Lobster'),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void _exitApp(BuildContext context) {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          fontFamily: 'Lobster',
          fontSize: 30,
          color: Colors.black87,
        ),
        backgroundColor: Colors.purple[100],
        title: const Center(child: Text("The Hangman Game!")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/Hangman.png',
                  height: 255,
                ),
              ),
              const Text(
                'H_NG__N G_M_',
                style: TextStyle(fontSize: 68),
              ),
              const SizedBox(height: 48),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return Play();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 60),
                      backgroundColor: Colors.deepPurple[100],
                    ),
                    child: const Text('Start', style: TextStyle(fontSize: 40)),
                  ),
                  const SizedBox(height: 37),
                  ElevatedButton(
                    onPressed: () {
                      _exitApp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 60),
                      backgroundColor: Colors.deepPurple[100],
                    ),
                    child: const Text('Exit', style: TextStyle(fontSize: 40)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
