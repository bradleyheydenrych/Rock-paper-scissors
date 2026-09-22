import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/choice_button.dart';

class GameScreen extends StatefulWidget {
  final String playerName;
  const GameScreen({super.key, required this.playerName});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _random = Random();

  RpsChoice? _playerChoice;
  RpsChoice? _computerChoice;
  String? _resultText;

  int _sessionWins = 0;
  int _sessionLosses = 0;
  int _sessionTies = 0;

  void _play(RpsChoice playerChoice) {
    final computerChoice = RpsChoice.values[_random.nextInt(3)];
    final String result;
    if (playerChoice == computerChoice) {
      result = 'tie';
    } else if (playerChoice.beats(computerChoice)) {
      result = 'win';
    } else {
      result = 'loss';
    }

    setState(() {
      _playerChoice = playerChoice;
      _computerChoice = computerChoice;
      _resultText = switch (result) {
        'win' => 'You win! 🎉',
        'loss' => 'Computer wins',
        _ => "It's a tie",
      };
      if (result == 'win') _sessionWins++;
      if (result == 'loss') _sessionLosses++;
      if (result == 'tie') _sessionTies++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.playerName} vs Computer')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Wins: $_sessionWins   Losses: $_sessionLosses   Ties: $_sessionTies',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              if (_playerChoice != null && _computerChoice != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text('You'),
                        Text(_playerChoice!.emoji,
                            style: const TextStyle(fontSize: 56)),
                      ],
                    ),
                    Text('vs', style: Theme.of(context).textTheme.titleLarge),
                    Column(
                      children: [
                        const Text('Computer'),
                        Text(_computerChoice!.emoji,
                            style: const TextStyle(fontSize: 56)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _resultText ?? '',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
              const Spacer(),
              Text('Make your move',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: RpsChoice.values
                    .map((c) => ChoiceButton(choice: c, onTap: () => _play(c)))
                    .toList(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}