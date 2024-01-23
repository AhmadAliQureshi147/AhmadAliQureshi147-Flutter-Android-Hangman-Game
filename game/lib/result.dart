import 'package:flutter/material.dart';
import 'package:game/play.dart';
import 'package:game/game.dart';

class Result extends StatelessWidget {
  final Game game;

  const Result.fromData(this.game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[100],
        titleTextStyle: const TextStyle(
          fontFamily: 'Lobster',
          fontSize: 30,
          color: Colors.black87,
        ),
        title: const Text("               Result 😮"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          iconSize: 36,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getResult(), // Call the _getResult method here
            Text(
              "Word: " + game.secretWord,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28),
            ),
            _getStars(), // Call the _getStars method here
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade200),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)), // Increase padding here
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Play();
                }));
              },
              child: const Text(
                "Next Word",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getResult() {
    // The implementation of _getResult method goes here.
    if (game.isWordGuessed()) {
      return Column(
        children: <Widget>[
          Image.asset(
            'images/wins.png',
            height: 170,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              "Victory! \u2764",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 52),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Image.asset(
            'images/cry.png',
            height: 250,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              "Better Luck\nNext Time 💔",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Pangolin',
                fontSize: 42,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _getStars() {
    // The implementation of _getStars method goes here.
    if (game.isWordGuessed()) {
      if (game.wrongLettersGuessed.length == 0)
        return Image.asset(
          "images/star3.png",
          height: 65,
        );
      else if (game.wrongLettersGuessed.length <= 2)
        return Image.asset(
          "images/star2.png",
          height: 65,
        );
      else
        return Image.asset(
          "images/star1.png",
          height: 65,
        );
    } else {
      return Image.asset(
        "images/star0.png",
        height: 65,
      );
    }
  }
}
