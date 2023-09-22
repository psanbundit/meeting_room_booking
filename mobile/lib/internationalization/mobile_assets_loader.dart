import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:meeting_room_booking/internationalization/secure_storage_handler.dart';

class MobileAssetsLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    Logger.d("Loading translations for locale ${locale.languageCode} from secure storage into EasyLocalization");
    final translationsMap = json.decode(await readTranslationsJson(locale));
    Logger.d("translations are: $translationsMap");

    return translationsMap;
  }
}
