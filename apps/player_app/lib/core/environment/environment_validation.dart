import 'app_environment.dart';
import 'environment_config.dart';

/// Validates environment configuration before Firebase initialization.
class EnvironmentValidation {
  EnvironmentValidation._();

  static String? validate(EnvironmentConfig config) {
    if (config.firebaseProjectId.isEmpty) {
      return 'firebaseProjectId is required.';
    }

    if (config.firebaseAppId.startsWith('REPLACE_WITH_')) {
      if (config.environment != AppEnvironment.development) {
        return 'Firebase app ID for ${config.environmentName} is not configured. '
            'Run flutterfire configure for project ${config.firebaseProjectId}.';
      }
    }

    if (config.firebaseMessagingSenderId.startsWith('REPLACE_WITH_') &&
        config.environment != AppEnvironment.development) {
      return 'Firebase messaging sender ID for ${config.environmentName} '
          'is not configured.';
    }

    if (_containsWrongEnvironmentMarker(config)) {
      return 'Firebase project ID does not match environment '
          '${config.environmentName}.';
    }

    if (config.isProduction && config.debugLoggingEnabled) {
      return 'Production configuration must not enable debug logging.';
    }

    if (config.isProduction && config.appCheckMode == 'debug') {
      return 'Production configuration must not use App Check debug mode.';
    }

    return null;
  }

  static bool _containsWrongEnvironmentMarker(EnvironmentConfig config) {
    final projectId = config.firebaseProjectId;
    return switch (config.environment) {
      AppEnvironment.development =>
        !projectId.contains('dev') || projectId.contains('prod'),
      AppEnvironment.staging => !projectId.contains('staging'),
      AppEnvironment.production =>
        !projectId.contains('prod') || projectId.contains('dev'),
    };
  }
}
