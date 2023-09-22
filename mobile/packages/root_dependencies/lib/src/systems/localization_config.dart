part of root_dependencies;

/// [supportedLocales[0] will be automatically used for fallback locale]
abstract class LocalizationConfig {
  final List<Locale> supportedLocales;
  final AssetLoader assetLoader;

  LocalizationConfig({
    required this.supportedLocales,
    required this.assetLoader,
  });

  Future<void> start();
}
