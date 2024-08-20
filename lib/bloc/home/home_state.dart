part of 'home_bloc.dart';

class HomeState {
  final List<ActiveBox> activeBox;
  final Player activePlayer;
  final List<ActiveBox>? winnerBoxes;

  bool get hasWinner => winnerBoxes?.length == 3;

  const HomeState(
      {required this.activeBox, required this.activePlayer, this.winnerBoxes});
}

final class PlayerBoxIntial extends HomeState {
  PlayerBoxIntial()
      : super(activeBox: [], activePlayer: Player.O, winnerBoxes: []);
}

final class PlayerBoxUpdated extends HomeState {
  const PlayerBoxUpdated({
    required super.activeBox,
    required super.activePlayer,
  });
}

final class PlayerWin extends HomeState {
  const PlayerWin({
    required super.activeBox,
    required super.activePlayer,
    required super.winnerBoxes,
  });
}
