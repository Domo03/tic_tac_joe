import 'package:tic_tac_joe/models/active_box_model.dart';

Direction? getDirection(List<ActiveBox> winnerBoxes, int row, int col) {
  if (winnerBoxes.where((r) => r.column == col).length == 3) {
    return Direction.vertical;
  } else if (winnerBoxes.where((r) => r.row == row).length == 3) {
    return Direction.horizontal;
  } else if (winnerBoxes.where((r) => r.row == r.column).length == 3) {
    return Direction.backslash;
  } else if (winnerBoxes.where((r) => r.row == 1 && r.column == 3).length ==
          1 &&
      winnerBoxes.where((r) => r.row == 2 && r.column == 2).length == 1 &&
      winnerBoxes.where((r) => r.row == 3 && r.column == 1).length == 1) {
    return Direction.forwardslash;
  }

  return null;
}
