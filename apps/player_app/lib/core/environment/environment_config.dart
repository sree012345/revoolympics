import 'app_environment.dart';

/// Immutable Firebase and hosting configuration for one environment.
class EnvironmentConfig {
  const EnvironmentConfig({
    required this.environment,
    required this.environmentName,
    required this.firebaseProjectId,
    required this.firebaseAppId,
    required this.firebaseMessagingSenderId,
    required this.firebaseStorageBucket,
    required this.firebaseAuthDomain,
    required this.firebaseHostingDomain,
    required this.gameHostingBaseUrl,
    required this.adminHostingBaseUrl,
    required this.functionsRegion,
    required this.analyticsEnabled,
    required this.crashlyticsEnabled,
    required this.appCheckMode,
    required this.debugLoggingEnabled,
    required this.androidApplicationId,
    required this.iosBundleId,
    required this.firebaseAppNickname,
    this.useFirebaseEmulators = false,
  });

  final AppEnvironment environment;
  final String environmentName;
  final String firebaseProjectId;
  final String firebaseAppId;
  final String firebaseMessagingSenderId;
  final String firebaseStorageBucket;
  final String firebaseAuthDomain;
  final String firebaseHostingDomain;
  final String gameHostingBaseUrl;
  final String adminHostingBaseUrl;
  final String functionsRegion;
  final bool analyticsEnabled;
  final bool crashlyticsEnabled;
  final String appCheckMode;
  final bool debugLoggingEnabled;
  final String androidApplicationId;
  final String iosBundleId;
  final String firebaseAppNickname;
  final bool useFirebaseEmulators;

  bool get isProduction => environment.isProduction;

  static const development = EnvironmentConfig(
    environment: AppEnvironment.development,
    environmentName: 'development',
    firebaseProjectId: 'revoolympics-dev',
    firebaseAppId: 'REPLACE_WITH_FLUTTERFIRE_DEV_APP_ID',
    firebaseMessagingSenderId: 'REPLACE_WITH_FLUTTERFIRE_DEV_SENDER_ID',
    firebaseStorageBucket: 'revoolympics-dev.firebasestorage.app',
    firebaseAuthDomain: 'revoolympics-dev.firebaseapp.com',
    firebaseHostingDomain: 'revoolympics-player-dev.web.app',
    gameHostingBaseUrl: 'https://revoolympics-games-dev.web.app',
    adminHostingBaseUrl: 'https://revoolympics-admin-dev.web.app',
    functionsRegion: 'asia-south1',
    analyticsEnabled: false,
    crashlyticsEnabled: false,
    appCheckMode: 'debug',
    debugLoggingEnabled: true,
    androidApplicationId: 'com.revolutiongames.revoolympics.dev',
    iosBundleId: 'com.revolutiongames.revoolympics.dev',
    firebaseAppNickname: 'revoolympics-player-dev',
    useFirebaseEmulators: false,
  );

  static const staging = EnvironmentConfig(
    environment: AppEnvironment.staging,
    environmentName: 'staging',
    firebaseProjectId: 'revoolympics-staging',
    firebaseAppId: 'REPLACE_WITH_FLUTTERFIRE_STAGING_APP_ID',
    firebaseMessagingSenderId: 'REPLACE_WITH_FLUTTERFIRE_STAGING_SENDER_ID',
    firebaseStorageBucket: 'revoolympics-staging.firebasestorage.app',
    firebaseAuthDomain: 'revoolympics-staging.firebaseapp.com',
    firebaseHostingDomain: 'revoolympics-player-staging.web.app',
    gameHostingBaseUrl: 'https://revoolympics-games-staging.web.app',
    adminHostingBaseUrl: 'https://revoolympics-admin-staging.web.app',
    functionsRegion: 'asia-south1',
    analyticsEnabled: true,
    crashlyticsEnabled: true,
    appCheckMode: 'enforced_test',
    debugLoggingEnabled: true,
    androidApplicationId: 'com.revolutiongames.revoolympics.staging',
    iosBundleId: 'com.revolutiongames.revoolympics.staging',
    firebaseAppNickname: 'revoolympics-player-staging',
  );

  static const production = EnvironmentConfig(
    environment: AppEnvironment.production,
    environmentName: 'production',
    firebaseProjectId: 'revoolympics-prod',
    firebaseAppId: 'REPLACE_WITH_FLUTTERFIRE_PROD_APP_ID',
    firebaseMessagingSenderId: 'REPLACE_WITH_FLUTTERFIRE_PROD_SENDER_ID',
    firebaseStorageBucket: 'revoolympics-prod.firebasestorage.app',
    firebaseAuthDomain: 'revoolympics-prod.firebaseapp.com',
    firebaseHostingDomain: 'play.revoolympics.com',
    gameHostingBaseUrl: 'https://games.revoolympics.com',
    adminHostingBaseUrl: 'https://admin.revoolympics.com',
    functionsRegion: 'asia-south1',
    analyticsEnabled: true,
    crashlyticsEnabled: true,
    appCheckMode: 'enforced',
    debugLoggingEnabled: false,
    androidApplicationId: 'com.revolutiongames.revoolympics',
    iosBundleId: 'com.revolutiongames.revoolympics',
    firebaseAppNickname: 'revoolympics-player-prod',
  );

  static EnvironmentConfig forEnvironment(AppEnvironment environment) =>
      switch (environment) {
        AppEnvironment.development => development,
        AppEnvironment.staging => staging,
        AppEnvironment.production => production,
      };
}
