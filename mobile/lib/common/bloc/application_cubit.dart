import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/common/bloc/application_state.dart';
import 'package:meeting_room_booking/internationalization/secure_storage_handler.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(const ApplicationState());

  Future<void> changeLocale(BuildContext context, Locale locale) async {
    await setStoredLanguageCode(locale.languageCode).then((_) async {
      await context.setLocale(locale);
    });
    emit(state.copyWith(currentSelectLocale: locale.languageCode));
  }

  Future<R> loadingEffect<R>(Future<R> Function() effect) async {
    try {
      emit(state.copyWith(toggleLoading: true));

      return await effect();
    } finally {
      emit(state.copyWith(toggleLoading: false));
    }
  }
}
