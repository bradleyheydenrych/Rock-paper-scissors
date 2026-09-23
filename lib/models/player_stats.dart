class PlayerStats {
  final String name;
  final int wins;
  final int losses;
  final int ties;

  PlayerStats({
    required this.name,
    this.wins = 0,
    this.losses = 0,
    this.ties = 0,
  });

  int get gamesPlayed => wins + losses + ties;

  double get winRate => gamesPlayed == 0 ? 0 : wins / gamesPlayed;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'wins': wins,
      'losses': losses,
      'ties': ties,
    };
  }

  factory PlayerStats.fromMap(Map<String, dynamic> map) {
    return PlayerStats(
      name: map['name'] ?? 'Unknown',
      wins: map['wins'] ?? 0,
      losses: map['losses'] ?? 0,
      ties: map['ties'] ?? 0,
    );
  }
}
