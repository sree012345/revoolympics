/// Supported Revo Olympics runtime environments.
enum AppEnvironment {
  development,
  staging,
  production;

  String get name => switch (this) {
        AppEnvironment.development => 'development',
        AppEnvironment.staging => 'staging',
        AppEnvironment.production => 'production',
      };

  bool get isProduction => this == AppEnvironment.production;

  static AppEnvironment? tryParse(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return switch (value.toLowerCase()) {
      'development' || 'dev' => AppEnvironment.development,
      'staging' => AppEnvironment.staging,
      'production' || 'prod' => AppEnvironment.production,
      _ => null,
    };
  }
}
