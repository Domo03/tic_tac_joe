enum Player { O, X }

class ActiveBox {
  final Player player;
  final int row;
  final int column;

  ActiveBox({required this.player, required this.row, required this.column});
}
