import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'leaderboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startGame() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a name first')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GameScreen(playerName: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('✊✋✌️', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                Text(
                  'Rock Paper Scissors',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Your name',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _startGame(),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _startGame,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: Text('Play'),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LeaderboardScreen()),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Leaderboard'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
