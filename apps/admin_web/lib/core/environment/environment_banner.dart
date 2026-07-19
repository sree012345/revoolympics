import 'package:flutter/material.dart';

import 'environment_config.dart';

/// Visual indicator for non-production environments.
class EnvironmentBanner extends StatelessWidget {
  const EnvironmentBanner({
    super.key,
    required this.config,
    required this.child,
  });

  final EnvironmentConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (config.isProduction) {
      return child;
    }

    final label = config.environmentName == 'development' ? 'DEV' : 'STAGING';
    final color =
        config.environmentName == 'development' ? Colors.orange : Colors.blue;

    return Banner(
      message: label,
      location: BannerLocation.topStart,
      color: color,
      child: child,
    );
  }
}
