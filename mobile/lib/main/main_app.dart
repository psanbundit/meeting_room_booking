import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking/common/bloc/application_cubit.dart';
import 'package:meeting_room_booking/common/bloc/application_state.dart';
import 'package:meeting_room_booking/internationalization/secure_storage_handler.dart';
import 'package:meeting_room_booking/routes.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late GoRouter _goRouter;

  _MainAppState() {
    _goRouter = Routes().router;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        initializeLocale(context),
      ]),
      builder: (___, ____) {
        if (____.hasError) {
          return MaterialApp.router(
            routerConfig: _goRouter,
          );
        }

        return BlocBuilder<ApplicationCubit, ApplicationState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Palo IT Meeting Room Booking App',
              localizationsDelegates: [
                ...context.localizationDelegates,
              ],
              supportedLocales: [
                ...context.supportedLocales,
                const Locale('thBudha'),
              ],
              locale: context.locale,
              theme: ThemeData(
                useMaterial3: true,
                splashFactory: NoSplash.splashFactory,
                elevatedButtonTheme: const ElevatedButtonThemeData(
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                  ),
                ),
              ),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: child ?? const SizedBox.shrink(),
              ),
              routerConfig: _goRouter,
            );
          },
        );
      },
    );
  }
}
