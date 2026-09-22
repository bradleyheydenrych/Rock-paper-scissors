# Rock Paper Scissors (Flutter + Firebase)

A rock-paper-scissors game built to practice Flutter/Dart alongside a real
backend. It's single-player — you play against a random computer opponent —
but every round is written to Cloud Firestore, so there's one shared,
live-updating leaderboard across everyone who plays, not just a local score.

**What it does:**

- Play rock-paper-scissors against a computer opponent that picks randomly
- Tracks session stats (wins/losses/ties) while you play
- Writes each round's result to Firestore via a transaction, so concurrent
  games never clobber each other's counts
- A separate leaderboard screen shows the top players globally, updating
  live as people play (no refresh needed) via a Firestore stream

**Built with:**

- Flutter / Dart for the UI and app logic
- Cloud Firestore for persistence and the live leaderboard
- FlutterFire CLI to wire the app to a Firebase project

## Project layout

WTC-EVXTUDKN