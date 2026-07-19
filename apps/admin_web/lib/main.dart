// Revo Olympics Admin Web
//
// Foundation Sprint F0.4 — structure only.
// Admin authentication and modules begin in Version 1, Sprint 1.4+.

import 'package:flutter/material.dart';

void main() {
  runApp(const RevoOlympicsAdminApp());
}

class RevoOlympicsAdminApp extends StatelessWidget {
  const RevoOlympicsAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revo Olympics Admin',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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
      appBar: AppBar(title: const Text('Revo Olympics Admin')),
      body: const Center(
        child: Text('Admin Web — Foundation structure (F0.4)'),
      ),
    );
  }
}
