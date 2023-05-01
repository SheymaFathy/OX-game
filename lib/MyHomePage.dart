import 'package:flutter/material.dart';
import 'package:ox_bloc/bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlr = 'X';
  bool GameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              title: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'اللعب مع الكمبيوتر/لاعب اخر',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'flu',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              value: isSwitched,
              onChanged: (bool newVal) {
                setState(() {
                  isSwitched = newVal;
                });
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              " $activePlr دور اللاعب".toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'flu',
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
                child: GridView.count(
              padding: const EdgeInsets.all(30),
              mainAxisSpacing: 8.0,
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
              children: List.generate(
                  9,
                  (index) => InkWell(
                        borderRadius: BorderRadius.circular(70),
                        onTap: GameOver ? null : () => _onTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(70)),
                          child: Center(
                            child: Text(
                              Player.playerX.contains(index)
                                  ? 'X'
                                  : Player.playerO.contains(index)
                                      ? 'O'
                                      : '',
                              style: TextStyle(
                                  color: Player.playerX.contains(index)
                                      ? Colors.yellow[700]
                                      : Colors.pink[700],
                                  fontSize: 70,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )),
            )),
            Text(
              result,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  Player.playerX = [];
                  Player.playerO = [];
                  activePlr = 'X';
                  GameOver = false;
                  turn = 0;
                  result = '';
                });
              },
              icon: Icon(
                Icons.repeat,
                color: Colors.black54,
              ),
              label: Text(
                'اعادة اللعب مرة ثانية',
                style: TextStyle(color: Colors.black54, fontFamily: 'flu'),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty ||
        !Player.playerX.contains(index) && Player.playerO.isEmpty ||
        !Player.playerO.contains(index))) {
      game.playGame(index, activePlr);
      updatState();

      if (!isSwitched && !GameOver) {
        await game.autoPlay(activePlr);
        updatState();
      }
    }
  }

  void updatState() {
    setState(() {
      activePlr = (activePlr == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        GameOver = true;
        result = '$winnerPlayer اللاعب الفائز';
      } else if (!GameOver && turn == 9) {
        result = "It's Draw";
      }
    });
  }
}
