import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/player_stats.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: StreamBuilder<List<PlayerStats>>(
        stream: firestoreService.leaderboardStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final players = snapshot.data!;
          if (players.isEmpty) {
            return const Center(child: Text('No games played yet'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: players.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final p = players[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(p.name),
                subtitle: Text('${p.wins}W / ${p.losses}L / ${p.ties}T'),
                trailing: Text('${(p.winRate * 100).toStringAsFixed(0)}%'),
              );
            },
          );
        },
      ),
    );
  }
}
