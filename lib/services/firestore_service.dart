import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player_stats.dart';

class FirestoreService {
  final CollectionReference _leaderboard =
      FirebaseFirestore.instance.collection('leaderboard');

  /// Fetches a player's current stats, or null if they haven't played yet.
  Future<PlayerStats?> getPlayerStats(String name) async {
    final doc = await _leaderboard.doc(name.toLowerCase()).get();
    if (!doc.exists) return null;
    return PlayerStats.fromMap(doc.data() as Map<String, dynamic>);
  }

  /// Records the result of a single round, creating the player's
  /// leaderboard entry the first time they play.
  Future<void> recordResult(String name, {required String result}) async {
    final docRef = _leaderboard.doc(name.toLowerCase());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        transaction.set(docRef, {
          'name': name,
          'wins': result == 'win' ? 1 : 0,
          'losses': result == 'loss' ? 1 : 0,
          'ties': result == 'tie' ? 1 : 0,
        });
      } else {
        final data = snapshot.data() as Map<String, dynamic>;
        transaction.update(docRef, {
          'wins': (data['wins'] ?? 0) + (result == 'win' ? 1 : 0),
          'losses': (data['losses'] ?? 0) + (result == 'loss' ? 1 : 0),
          'ties': (data['ties'] ?? 0) + (result == 'tie' ? 1 : 0),
        });
      }
    });
  }

  /// Live-updating leaderboard, top players by wins.
  Stream<List<PlayerStats>> leaderboardStream() {
    return _leaderboard
        .orderBy('wins', descending: true)
        .limit(20)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                PlayerStats.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
