import 'app_environment.dart';
import 'environment_config.dart';
import 'environment_validation.dart';

/// Loads and validates the active environment from compile-time defines.
class EnvironmentLoader {
  EnvironmentLoader._();

  static const _envDefineKey = 'REVO_ENV';
  static const _useEmulatorsDefineKey = 'USE_FIREBASE_EMULATORS';

  static EnvironmentLoadResult load() {
    const rawEnv = String.fromEnvironment(_envDefineKey);
    const useEmulators =
        bool.fromEnvironment(_useEmulatorsDefineKey, defaultValue: false);

    final environment = AppEnvironment.tryParse(rawEnv);
    if (environment == null) {
      return EnvironmentLoadResult.failure(
        'Missing or invalid $_envDefineKey. '
        'Pass --dart-define=REVO_ENV=development|staging|production. '
        'The app must not default to production.',
      );
    }

    var config = EnvironmentConfig.forEnvironment(environment);

    if (useEmulators) {
      if (config.isProduction) {
        return EnvironmentLoadResult.failure(
          'USE_FIREBASE_EMULATORS cannot be enabled for production builds.',
        );
      }
      config = EnvironmentConfig(
        environment: config.environment,
        environmentName: config.environmentName,
        firebaseProjectId: config.firebaseProjectId,
        firebaseAppId: config.firebaseAppId,
        firebaseMessagingSenderId: config.firebaseMessagingSenderId,
        firebaseStorageBucket: config.firebaseStorageBucket,
        firebaseAuthDomain: config.firebaseAuthDomain,
        firebaseHostingDomain: config.firebaseHostingDomain,
        gameHostingBaseUrl: config.gameHostingBaseUrl,
        adminHostingBaseUrl: config.adminHostingBaseUrl,
        functionsRegion: config.functionsRegion,
        analyticsEnabled: config.analyticsEnabled,
        crashlyticsEnabled: config.crashlyticsEnabled,
        appCheckMode: config.appCheckMode,
        debugLoggingEnabled: config.debugLoggingEnabled,
        androidApplicationId: config.androidApplicationId,
        iosBundleId: config.iosBundleId,
        firebaseAppNickname: config.firebaseAppNickname,
        useFirebaseEmulators: true,
      );
    }

    final validationError = EnvironmentValidation.validate(config);
    if (validationError != null) {
      return EnvironmentLoadResult.failure(validationError);
    }

    return EnvironmentLoadResult.success(config);
  }
}

class EnvironmentLoadResult {
  const EnvironmentLoadResult._({
    required this.config,
    required this.errorMessage,
  });

  final EnvironmentConfig? config;
  final String? errorMessage;

  bool get isSuccess => config != null && errorMessage == null;

  static EnvironmentLoadResult success(EnvironmentConfig config) =>
      EnvironmentLoadResult._(config: config, errorMessage: null);

  static EnvironmentLoadResult failure(String message) =>
      EnvironmentLoadResult._(config: null, errorMessage: message);
}
