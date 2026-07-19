// Revo Olympics Player Application
//
// Foundation Sprint F0.4 — structure only.
// Version 1 implementation begins in Sprint 1.1.
//
// Planned folders:
//   lib/app/       — app shell, routing, theme
//   lib/core/      — config, firebase, localization, navigation
//   lib/features/  — home, games, unity_player, settings, ...
//   lib/shared/    — reusable widgets

import 'package:flutter/material.dart';

void main() {
  runApp(const RevoOlympicsPlayerApp());
}

class RevoOlympicsPlayerApp extends StatelessWidget {
  const RevoOlympicsPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revo Olympics',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const _PlaceholderHome(),
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Revo Olympics')),
      body: const Center(
        child: Text('Player app — Foundation structure (F0.4)'),
      ),
    );
  }
}
