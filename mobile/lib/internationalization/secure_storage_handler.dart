import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:meeting_room_booking/common/bloc/application_cubit.dart';
import 'package:meeting_room_booking_services/services.dart';
import 'package:root_dependencies/root_dependencies.dart';
import 'package:sprintf/sprintf.dart';

import 'internationalization_constants.dart';

import 'package:easy_localization/easy_localization.dart';

Future<bool> initializeLocale(BuildContext context) async {
  try {
    await _initializeStoredLanguageIfNeeded();

    Logger.d("Called initializeLocale");
    final storedLanguageCode = await readStoredLanguageCode();
    Logger.d("Read languageCode $storedLanguageCode");
    Logger.d("Locale $Locale(storedLanguageCode)");

    Future.delayed(Duration.zero, () async {
      await context.setLocale(Locale(storedLanguageCode));
    });
    SystemDependencies.of<ApplicationCubit>().state.copyWith(
          currentSelectLocale: storedLanguageCode,
        );

    return true;
  } catch (e, stackTrace) {
    Logger.e(e.toString());
    Logger.e(stackTrace);

    return false;
  }
}

Future<void> _initializeStoredLanguageIfNeeded() async {
  if (await _getStoredLanguageCode() == null) {
    final platformLanguageCode = Platform.localeName.split("_").first;
    switch (platformLanguageCode) {
      case "en":
      case "th":
        await setStoredLanguageCode(platformLanguageCode);
        break;
      default:
        await setStoredLanguageCode("en");
    }
  }
}

Future<String> readStoredLanguageCode() async {
  final storedLanguageCode = await _getStoredLanguageCode();

  return storedLanguageCode ?? 'th';
}

Future<String?> _getStoredLanguageCode() async {
  return await SystemDependencies.of<SecureStorageService>().read(
    key: storedLanguageCodeKey,
  );
}

Future<void> setStoredLanguageCode(String languageCode) async {
  Logger.d("Storing languageCode $languageCode");
  await SystemDependencies.of<SecureStorageService>().write(
    key: storedLanguageCodeKey,
    value: languageCode,
  );
}

Future<String> readTranslationsJson(Locale locale) async {
  return await SystemDependencies.of<SecureStorageService>().read(
        key: sprintf(
          translationKey,
          [
            locale.languageCode,
          ],
        ),
      ) ??
      "{}";
}

Future loadTranslation(Locale locale, bool forceReload) async {
  final storage = SystemDependencies.of<SecureStorageService>();
  final storedLastModifiedDateString = await storage.read(key: _translationLastModifiedDateKey(locale));
  final Map<String, dynamic> metaDataInfos = jsonDecode(await rootBundle.loadString("translations/metadata.json"));
  final fileLastModifiedDate = DateTime.parse(metaDataInfos[locale.languageCode]);

  if ((storedLastModifiedDateString == null || //
      fileLastModifiedDate.isAfter(DateTime.parse(storedLastModifiedDateString)) ||
      forceReload)) {
    await _loadTranslationFromFile(storage, fileLastModifiedDate, locale);
  } else {
    Logger.d("Locale is already up to date");
  }

  Logger.d("Loaded translation ${locale.languageCode} into secure storage");
}

Future _loadTranslationFromFile(
  SecureStorageService storage,
  DateTime lastModificationDate,
  Locale locale,
) async {
  Logger.d("Loading translation ${locale.languageCode} from file");

  final filePath = 'translations/${locale.languageCode}.json';
  await storage.write(
    key: _translationLastModifiedDateKey(locale),
    value: lastModificationDate.toIso8601String(),
  );
  await storage.write(
    key: _translationKey(locale),
    value: await rootBundle.loadString(filePath),
  );
}

String _translationLastModifiedDateKey(Locale locale) {
  return sprintf(translationLastModifiedDateKey, [
    locale.languageCode,
  ]);
}

String _translationKey(Locale locale) {
  return sprintf(translationKey, [
    locale.languageCode,
  ]);
}
