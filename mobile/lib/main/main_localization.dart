import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meeting_room_booking/internationalization/mobile_assets_loader.dart';
import 'package:meeting_room_booking/internationalization/secure_storage_handler.dart';
import 'package:root_dependencies/root_dependencies.dart';

const supportedLocales = [
  Locale("en"),
  Locale("th"),
];

class MainLocalization extends LocalizationConfig {
  MainLocalization()
      : super(
          supportedLocales: supportedLocales,
          assetLoader: MobileAssetsLoader(),
        );

  @override
  Future<void> start() async {
    // final forceReload = dotenv.get('STAGE') == 'dev';
    // for (final locale in supportedLocales) {
    //   await loadTranslation(locale, true);
    // }
  }
}
