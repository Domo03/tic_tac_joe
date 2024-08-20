import "package:flutter_bloc/flutter_bloc.dart";
import "package:tic_tac_joe/models/active_box_model.dart";

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(PlayerBoxIntial()) {
    on<AddActiveBox>(_addActiveBox);
    on<ResetBox>(_resetBox);
  }

  void _addActiveBox(AddActiveBox event, Emitter<HomeState> emit) {
    if (!state.activeBox.any((a) =>
        a.column == event.activeBox.column && a.row == event.activeBox.row)) {
      state.activeBox.add(event.activeBox);

      var currentPlayer = event.activeBox.player;
      var newActivevPlayer = event.activeBox.player;
      if (newActivevPlayer == Player.O) {
        newActivevPlayer = Player.X;
      } else {
        newActivevPlayer = Player.O;
      }
      List<ActiveBox> winningBoxes =
          _checkWinnerBox(state.activeBox, currentPlayer);

      if (winningBoxes.length == 3) {
        emit(
          PlayerWin(
            activeBox: state.activeBox,
            activePlayer: newActivevPlayer,
            winnerBoxes: winningBoxes,
          ),
        );
      } else {
        emit(PlayerBoxUpdated(
            activeBox: state.activeBox, activePlayer: newActivevPlayer));
      }
    }
  }

  List<ActiveBox> _checkWinnerBox(
      List<ActiveBox> activeBoxes, Player currentPlayer) {
    List<ActiveBox> winningBoxes = List.empty(growable: true);

    var playerBoxes = activeBoxes.where((item) => item.player == currentPlayer);

    if (playerBoxes.length >= 3) {
      // horizontal
      for (int col = 1; col <= 3; col++) {
        for (int row = 1; row <= 3; row++) {
          ActiveBox? box = playerBoxes
              .where((item) => item.column == col && item.row == row)
              .firstOrNull;
          if (box != null) {
            winningBoxes.add(box);
          } else {
            winningBoxes = List.empty(growable: true);
            break;
          }
        }

        if (winningBoxes.length == 3) {
          return winningBoxes;
        }
      }
      // reset
      winningBoxes = List.empty(growable: true);

      // vertical
      for (int row = 1; row <= 3; row++) {
        for (int col = 1; col <= 3; col++) {
          ActiveBox? box = playerBoxes
              .where((item) => item.column == col && item.row == row)
              .firstOrNull;
          if (box != null) {
            winningBoxes.add(box);
          } else {
            winningBoxes = List.empty(growable: true);
            break;
          }
        }

        if (winningBoxes.length == 3) {
          return winningBoxes;
        }
      }
      // reset
      winningBoxes = List.empty(growable: true);

      // diagonal forward slash
      int rowPos3 = 3;
      for (int col = 1; col <= 3; col++) {
        ActiveBox? box = playerBoxes
            .where((item) => item.column == col && item.row == rowPos3)
            .firstOrNull;
        if (box != null) {
          winningBoxes.add(box);
          --rowPos3;
        } else {
          break;
        }

        if (winningBoxes.length == 3) {
          return winningBoxes;
        }
      }

      // reset
      winningBoxes = List.empty(growable: true);

      // diagonal backward slash
      int rowPos1 = 1;
      for (int col = 1; col <= 3; col++) {
        ActiveBox? box = playerBoxes
            .where((item) => item.column == col && item.row == rowPos1)
            .firstOrNull;
        if (box != null) {
          winningBoxes.add(box);
          ++rowPos1;
        } else {
          break;
        }

        if (winningBoxes.length == 3) {
          return winningBoxes;
        }
      }
    }

    // reset
    winningBoxes = List.empty(growable: true);

    return winningBoxes;
  }

  void _resetBox(ResetBox event, Emitter<HomeState> emit) {
    emit(PlayerBoxIntial());
  }
}
