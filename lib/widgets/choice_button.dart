import 'package:flutter/material.dart';

enum RpsChoice { rock, paper, scissors }

extension RpsChoiceX on RpsChoice {
  String get emoji {
    switch (this) {
      case RpsChoice.rock:
        return '✊';
      case RpsChoice.paper:
        return '✋';
      case RpsChoice.scissors:
        return '✌️';
    }
  }

  String get label {
    switch (this) {
      case RpsChoice.rock:
        return 'Rock';
      case RpsChoice.paper:
        return 'Paper';
      case RpsChoice.scissors:
        return 'Scissors';
    }
  }

  /// True if this choice beats [other] under standard RPS rules.
  bool beats(RpsChoice other) {
    return (this == RpsChoice.rock && other == RpsChoice.scissors) ||
        (this == RpsChoice.paper && other == RpsChoice.rock) ||
        (this == RpsChoice.scissors && other == RpsChoice.paper);
  }
}

class ChoiceButton extends StatelessWidget {
  final RpsChoice choice;
  final VoidCallback? onTap;

  const ChoiceButton({super.key, required this.choice, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(choice.emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 4),
              Text(choice.label),
            ],
          ),
        ),
      ),
    );
  }
}
