import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_joe/bloc/home/home_bloc.dart';
import 'package:tic_tac_joe/helpers/direction_helpers.dart';
import 'package:tic_tac_joe/pages/home/widgets/triangle_widget.dart';
import 'package:tic_tac_joe/pages/result/result_screen.dart';
import 'package:tic_tac_joe/models/active_box_model.dart';

class CardBox extends StatelessWidget {
  const CardBox({
    super.key,
    required this.colNumber,
    required this.rowNumber,
    required this.boxCount,
  });

  final double colNumber;
  final double rowNumber;
  final double boxCount;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double boxWidth = screenWidth / boxCount;
    const borderSide = BorderSide(color: Colors.black, width: 3);

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.hasWinner) {
          var playerName = state.winnerBoxes!.first.player.name;
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return ResultScreen(playerName: playerName);
              },
            ),
          );
        }
      },
      builder: (context, state) {
        var activeBoxes = state.activeBox;
        var activePlayer = state.activePlayer;
        return Column(
          children: [
            for (int c = 1; c <= colNumber; c++) ...[
              Row(
                children: [
                  for (int r = 1; r <= boxCount; r++) ...[
                    InkWell(
                      onTap: state.hasWinner
                          ? null
                          : () {
                              var activeBox = ActiveBox(
                                  player: activePlayer, row: r, column: c);

                              context.read<HomeBloc>().add(
                                    AddActiveBox(activeBox: activeBox),
                                  );
                            },
                      splashColor: Theme.of(context).primaryColorLight,
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            width: boxWidth,
                            height: boxWidth,
                            decoration: BoxDecoration(
                              color: state.hasWinner &&
                                      state.winnerBoxes!.any(
                                          (w) => w.column == c && w.row == r)
                                  ? Colors.greenAccent
                                  : null,
                              border: Border(
                                top: BorderSide.none,
                                right: r == 3 ? BorderSide.none : borderSide,
                                bottom: c == 3 ? BorderSide.none : borderSide,
                                left: BorderSide.none,
                              ),
                            ),
                            child: Text(
                              activeBoxes
                                      .where((a) => a.row == r && a.column == c)
                                      .firstOrNull
                                      ?.player
                                      .name
                                      .toUpperCase() ??
                                  "",
                              style: TextStyle(
                                fontSize: boxWidth / 1.5,
                              ),
                            ),
                          ),
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state.hasWinner &&
                                  state.winnerBoxes!.any(
                                      (w) => w.column == c && w.row == r)) {
                                return _slashBox(
                                    state.winnerBoxes!, c, r, boxWidth);
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _slashBox(
      List<ActiveBox> winnerBoxes, int col, int row, double boxWidth) {
    Direction? direction = getDirection(winnerBoxes, row, col);

    return CustomBoxSlash(
      width: boxWidth,
      height: boxWidth,
      direction: direction!,
    );
  }
}
