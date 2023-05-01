import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContaisAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  void playGame(int index, String activePlr) {
    if (activePlr == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWinner() {
    String winner = '';

    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8) ||
        Player.playerX.containsAll(0, 4, 8) ||
        Player.playerX.containsAll(2, 4, 6))
      winner = 'X';
    else if (Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(2, 5, 8) ||
        Player.playerO.containsAll(0, 4, 8) ||
        Player.playerO.containsAll(2, 4, 6))
      winner = 'O';
    else {
      winner = '';
    }
    return winner;
  }

  Future<void> autoPlay(activePlr) async {
    int index = 0;
    List<int> emptyCell = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i)))
        emptyCell.add(i);
    }
    Random random = Random();
    int randomIndex = random.nextInt(emptyCell.length);

    index = emptyCell[randomIndex];
    playGame(index, activePlr);
  }
}

class MyBloc extends Bloc<MyBlocEvent, MyBlocState> {
  // MyBloc(super.initialState);
  MyBloc() : super(MyBlocState());

  @override
  Stream<MyBlocState> mapEventToState(MyBlocEvent e) async* {
    if (e.type == "Clk") {
      yield MyBlocState().play();
    }
  }
}

class MyBlocEvent {
  String type = "Clk";

  MyBlocEvent(this.type);
}

class MyBlocState {
  int count = 0;

  MyBlocState play() {
    MyBlocState x = new MyBlocState();
    return x;
  }
}
