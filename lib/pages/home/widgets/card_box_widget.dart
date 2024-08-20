import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_joe/bloc/home/home_bloc.dart';
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
                      child: SizedBox(
                        width: boxWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: state.hasWinner &&
                                    state.winnerBoxes!
                                        .any((w) => w.column == c && w.row == r)
                                ? Colors.green
                                : null,
                            border: Border(
                              top: BorderSide.none,
                              right: r == 3 ? BorderSide.none : borderSide,
                              bottom: c == 3 ? BorderSide.none : borderSide,
                              left: BorderSide.none,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              activeBoxes
                                      .where((a) => a.row == r && a.column == c)
                                      .firstOrNull
                                      ?.player
                                      .name
                                      .toUpperCase() ??
                                  "",
                              style: TextStyle(
                                fontSize: boxWidth - 8,
                              ),
                            ),
                          ),
                        ),
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
}
