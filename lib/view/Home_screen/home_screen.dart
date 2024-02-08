import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onTurn = true; //the first player is o
  List<String> displayExoh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
              child: Container(
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Player X", style: myNewFontWhite),
                      SizedBox(
                        height: 20,
                      ),
                      Text(ohScore.toString(), style: myNewFontWhite),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Player O", style: myNewFontWhite),
                      SizedBox(
                        height: 20,
                      ),
                      Text(exScore.toString(), style: myNewFontWhite),
                    ],
                  ),
                )
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Center(
                        child: Text(
                      displayExoh[index],
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    )),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: Container(
                  // color: Colors.red,
                  )),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (onTurn && displayExoh[index] == '') {
        displayExoh[index] = 'o';
        filledBoxes += 1;
      } else if (!onTurn && displayExoh[index] == '') {
        displayExoh[index] = 'x';
        filledBoxes += 1;
      }
      onTurn = !onTurn;
      _checkwinner();
    });
  }

  void _checkwinner() {
    // 1 Row check
    if (displayExoh[0] == displayExoh[1] &&
        displayExoh[0] == displayExoh[2] &&
        displayExoh[0] != '') {
      _showWinDialogue(displayExoh[0]);
    }

    // 2 Row check
    if (displayExoh[3] == displayExoh[4] &&
        displayExoh[3] == displayExoh[5] &&
        displayExoh[3] != '') {
      _showWinDialogue(displayExoh[3]);
    }

    // 3 Row check
    if (displayExoh[6] == displayExoh[7] &&
        displayExoh[6] == displayExoh[8] &&
        displayExoh[6] != '') {
      _showWinDialogue(displayExoh[6]);
    }

    // 1 Column check
    if (displayExoh[0] == displayExoh[3] &&
        displayExoh[0] == displayExoh[6] &&
        displayExoh[0] != '') {
      _showWinDialogue(displayExoh[0]);
    }

    // 2 Column check
    if (displayExoh[1] == displayExoh[4] &&
        displayExoh[1] == displayExoh[7] &&
        displayExoh[1] != '') {
      _showWinDialogue(displayExoh[1]);
    }

    // 3 Column check
    if (displayExoh[2] == displayExoh[5] &&
        displayExoh[2] == displayExoh[8] &&
        displayExoh[2] != '') {
      _showWinDialogue(displayExoh[2]);
    }

    // check diagonal
    if (displayExoh[6] == displayExoh[4] &&
        displayExoh[6] == displayExoh[2] &&
        displayExoh[6] != '') {
      _showWinDialogue(displayExoh[6]);
    }

    // Check diagonal
    if (displayExoh[0] == displayExoh[4] &&
        displayExoh[0] == displayExoh[8] &&
        displayExoh[0] != '') {
      _showWinDialogue(displayExoh[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialogue();
    }
  }

  void _showDrawDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Draw"),
          actions: [
            TextButton(
              child: Text("Play again"),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _showWinDialogue(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Winner is:" + winner),
          actions: [
            TextButton(
              child: Text("Play Again"),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
    _clearBoard;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExoh[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
