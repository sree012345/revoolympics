import 'package:flutter/material.dart';

import 'core/environment/environment_banner.dart';
import 'core/environment/environment_config.dart';
import 'core/environment/environment_loader.dart';

void main() {
  final result = EnvironmentLoader.load();
  if (!result.isSuccess) {
    runApp(EnvironmentErrorApp(message: result.errorMessage!));
    return;
  }

  runApp(RevoOlympicsAdminApp(config: result.config!));
}

class RevoOlympicsAdminApp extends StatelessWidget {
  const RevoOlympicsAdminApp({super.key, required this.config});

  final EnvironmentConfig config;

  @override
  Widget build(BuildContext context) {
    return EnvironmentBanner(
      config: config,
      child: MaterialApp(
        title: 'Revo Olympics Admin',
        debugShowCheckedModeBanner: config.debugLoggingEnabled,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: _PlaceholderHome(config: config),
      ),
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome({required this.config});

  final EnvironmentConfig config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Revo Olympics Admin')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Environment: ${config.environmentName}'),
            Text('Project: ${config.firebaseProjectId}'),
            Text('Admin: ${config.adminHostingBaseUrl}'),
            const SizedBox(height: 16),
            const Text('Foundation F0.5 — environment layer active.'),
          ],
        ),
      ),
    );
  }
}

class EnvironmentErrorApp extends StatelessWidget {
  const EnvironmentErrorApp({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Configuration error:\n$message',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
