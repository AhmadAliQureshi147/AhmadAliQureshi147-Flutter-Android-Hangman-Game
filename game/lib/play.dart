import 'package:flutter/material.dart';
import 'package:game/result.dart';
import 'package:game/game.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  Game? game; // Make 'game' field nullable and initialize as null

  @override
  void initState() {
    super.initState();
    game = Game();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent[100],
          titleTextStyle: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 30,
            color: Colors.black87,
          ),
          title: Text("                Play 😄"),
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            iconSize: 36, // Set the size of the back arrow icon
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: (game!.wrongLettersGuessed.length == 6)
                        ? ((MediaQuery.of(context).size.width / 2) - 84.5)
                        : ((MediaQuery.of(context).size.width / 2) - 78),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'images/hangman' +
                          game!.wrongLettersGuessed.length.toString() +
                          '.png',
                      height: 120,
                    ),
                  ),
                ],
              ),
              Text(
                game!.displayWord,
                style: TextStyle(fontSize: 48),
              ),
              SizedBox(height: 20), // Add vertical spacing between the image and the keypad
              Padding(
                padding: const EdgeInsets.only(bottom: 74.0),
                child: _getKeyPad(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getKeyPad() {
    List<List<String>> letters = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
    ];
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0),
          child: _getRow(0, letters),
        ),
        SizedBox(height: 15), // Add vertical spacing between the first and second row of buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: _getRow(1, letters),
        ),
        SizedBox(height: 15), // Add vertical spacing between the second and third row of buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: _getRow(2, letters),
        ),
      ],
    );
  }

  Row _getRow(int rowIndex, List<List<String>> letters) {
    List<Widget> row = [];
    for (int i = 0; i < letters[rowIndex].length; i++) {
      row.add(_getLetterButton(letters[rowIndex][i]));
    }
    return Row(
      children: row,
    );
  }

  Widget _getLetterButton(String letter) {
    return Padding(
      padding: const EdgeInsets.all(3.1), // Increase padding for more space around buttons
      child: Builder(
        builder: (BuildContext context) {
          Color buttonColor = _getLetterColor(letter);

          return GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width / 13, // Increase the width for bigger buttons
              height: 80, // Increase the height for bigger buttons
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  color: Colors.black, // Change text color to white for better visibility
                  fontSize: 34, // Adjust font size for bigger buttons
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)), // Increase border radius for rounded corners
                color: buttonColor,
              ),
            ),
            onTap: () {
              if (game!.displayWordList.contains(letter) ||
                  game!.wrongLettersGuessed.contains(letter)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Already Guessed",
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    letter,
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                ));
                setState(() {
                  game!.guessLetter(letter);
                });
                if (game!.isWordGuessed() || game!.hasLost()) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Result.fromData(game!);
                  }));
                }
              }
            },
          );
        },
      ),
    );
  }

  Color _getLetterColor(String letter) {
    if (game!.displayWordList.contains(letter)) {
      return Colors.green;
    } else if (game!.wrongLettersGuessed.contains(letter)) {
      return Colors.redAccent;
    } else {
      return Colors.purple.shade200;
    }
  }
}
