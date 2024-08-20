import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.playerName,
  });

  final String playerName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close_outlined,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white.withOpacity(0.8),
        body: Center(
          child: Text(
            'Player $playerName Win!',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
