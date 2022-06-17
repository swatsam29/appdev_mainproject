import 'package:flutter/material.dart';
import 'package:project2/model/constants.dart';
import 'package:project2/model/scores.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const routeName = '/playScreen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late _Controller controller;
  @override
  void initState() {
    super.initState();
    controller = _Controller(this);
  }

  Constants constants = Constants();
  Scores scores = Scores();
  void _decrementCard1() {
    if (scores.card1 > 0) {
      setState(() {
        scores.card1--;
        scores.balance++;
      });
    }
  }

  void _decrementCard2() {
    if (scores.card2 > 0) {
      setState(() {
        scores.card2--;
        scores.balance++;
      });
    }
  }

  void _decrementCard3() {
    if (scores.card3 > 0) {
      setState(() {
        scores.card3--;
        scores.balance++;
      });
    }
  }

  void _incrementCard1() {
    if (scores.card1 >= 0 && scores.card1 < 3 && scores.balance > 0) {
      setState(() {
        scores.card1++;
        scores.balance--;
      });
    }
  }

  void _incrementCard2() {
    if (scores.card2 >= 0 && scores.card2 < 3 && scores.balance > 0) {
      setState(() {
        scores.card2++;
        scores.balance--;
      });
    }
  }

  void showImage() {
    setState(() {
      scores.hide = !scores.hide;
    });
  }

  void _incrementCard3() {
    if (scores.card3 >= 0 && scores.card3 < 3 && scores.balance > 0) {
      setState(() {
        scores.card3++;
        scores.balance--;
      });
    }
  }

  void shuffleList() {
    setState(() {
      constants.images.shuffle();
    });
  }

  void play() {
    if (scores.card1 == 0 && scores.card2 == 0 && scores.card3 == 0) {
      return;
    }
    if ((constants.images.indexOf(flutterImage) + 1) == 1) {
      setState(() {
        scores.balance += scores.card1 * 3;
        scores.winner = scores.card1;
      });
    } else if ((constants.images.indexOf(flutterImage) + 1) == 2) {
      setState(() {
        scores.balance += scores.card2 * 3;
        scores.winner = scores.card2;
      });
    } else if ((constants.images.indexOf(flutterImage) + 1) == 3) {
      setState(() {
        scores.balance += scores.card3 * 3;
        scores.winner = scores.card3;
      });
    }
    setState(() {
      scores.results = true;
      scores.newGame = true;
    });
  }

  void _newGame() {
    if (scores.balance != 0) {
      shuffleList();
      setState(() {
        scores.results = false;
        scores.newGame = false;
        scores.card1 = scores.card2 = scores.card3 = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Where is the Flutter?"),
        actions: [
          InkWell(
            onTap: showImage,
            child: Container(
              alignment: Alignment.center,
              width: 76,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text(scores.hide ? "Show Key" : "Hide Key"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 12),
              !scores.hide
                  ? Text(
                      'SECRET: (The Flutter is at Card-${constants.images.indexOf(flutterImage)})',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                          backgroundColor: Colors.black),
                    )
                  : const SizedBox(height: 2),
              const SizedBox(height: 16),
              Text(
                'Balance: ${scores.balance} coins(Debts: ${scores.debt} coins)',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          !scores.results
                              ? Image.asset(
                                  constants.images[0] == flutterImage
                                      ? emptyCard
                                      : constants.images[0],
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  constants.images[0] == flutterImage
                                      ? constants.images[0]
                                      : resultImage,
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.fill,
                                ),
                          const SizedBox(height: 10),
                          Container(
                            color: Colors.blue,
                            width: 90,
                            height: 45,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: _decrementCard1,
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: (scores.card1 == 0)
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                  const SizedBox(width: 12),
                                  Text(
                                    "${scores.card1}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 26),
                                  ),
                                  const SizedBox(width: 12),
                                  InkWell(
                                      onTap: _incrementCard1,
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: (scores.card1 == 3 ||
                                                    scores.balance == 0)
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                ]),
                          ),
                        ]),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !scores.results
                            ? Image.asset(
                                constants.images[1] == flutterImage
                                    ? emptyCard
                                    : constants.images[1],
                                width: 100,
                                height: 150,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                constants.images[1] == flutterImage
                                    ? constants.images[1]
                                    : resultImage,
                                width: 100,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                        const SizedBox(height: 10),
                        Container(
                          color: Colors.blue,
                          width: 90,
                          height: 45,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: _decrementCard2,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: (scores.card2 == 0)
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                const SizedBox(width: 12),
                                Text(
                                  "${scores.card2}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 26),
                                ),
                                const SizedBox(width: 12),
                                InkWell(
                                    onTap: _incrementCard2,
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: (scores.card2 == 3 ||
                                                  scores.balance == 0)
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !scores.results
                            ? Image.asset(
                                constants.images[2] == flutterImage
                                    ? emptyCard
                                    : constants.images[2],
                                width: 100,
                                height: 150,
                                fit: BoxFit.fill)
                            : Image.asset(
                                constants.images[2] == flutterImage
                                    ? constants.images[2]
                                    : resultImage,
                                width: 100,
                                height: 150,
                                fit: BoxFit.fill),
                        const SizedBox(height: 10),
                        Container(
                          color: Colors.blue,
                          width: 90,
                          height: 45,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: _decrementCard3,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: (scores.card3 == 0)
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                const SizedBox(width: 12),
                                Text(
                                  "${scores.card3}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 26),
                                ),
                                const SizedBox(width: 12),
                                InkWell(
                                    onTap: _incrementCard3,
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: (scores.card3 == 3 ||
                                                  scores.balance == 0)
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                              ]),
                        ),
                      ],
                    ),
                  ]),
              const SizedBox(height: 20),
              Center(
                child: scores.newGame
                    ? InkWell(
                        onTap: _newGame,
                        child: Container(
                          alignment: Alignment.center,
                          width: 76,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              color: (scores.balance == 0)
                                  ? Colors.grey
                                  : Colors.blue),
                          child: Text(
                            "New Game",
                            style: TextStyle(
                                color: (scores.balance == 0)
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ))
                    : InkWell(
                        onTap: play,
                        child: Container(
                          alignment: Alignment.center,
                          width: 76,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              color: (scores.card1 == 0 &&
                                      scores.card2 == 0 &&
                                      scores.card3 == 0)
                                  ? Colors.grey
                                  : Colors.blue),
                          child: Text(
                            "Play",
                            style: TextStyle(
                                color: (scores.card1 == 0 &&
                                        scores.card2 == 0 &&
                                        scores.card3 == 0)
                                    ? Colors.yellow
                                    : Colors.white),
                          ),
                        )),
              ),
              const SizedBox(
                height: 16,
              ),
              scores.results
                  ? Text(
                      'You won ${scores.winner} (bet) x 3 = ${scores.winner * 3}coin(s)',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(
                      height: 10,
                    ),
              scores.balance == 0 && scores.results
                  ? const Text(
                      'No balance.Loan to play',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(
                      height: 10,
                    ),
              scores.balance == 0 && scores.results
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          scores.balance += 8;
                          scores.debt += 8;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: Colors.blue),
                        child: const Text(
                          "Borrow 8 coins",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods
  }
}

class _Controller {
  late _GameScreenState state;
  _Controller(this.state);
}
