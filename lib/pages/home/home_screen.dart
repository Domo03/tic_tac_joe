import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_joe/bloc/home/home_bloc.dart';

import 'widgets/card_box_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Tic-Tac-Joe'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Text(
                'Turn: Player ${state.activePlayer.name}',
                style: Theme.of(context).textTheme.titleLarge,
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const CardBox(
            colNumber: 3,
            rowNumber: 3,
            boxCount: 3,
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.replay_outlined),
            onPressed: () {
              context.read<HomeBloc>().add(ResetBox());
            },
            label: const Text('Play Again'),
          ),
        ],
      ),
    );
  }
}
