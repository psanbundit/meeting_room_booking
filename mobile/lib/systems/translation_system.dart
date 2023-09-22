import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:root_dependencies/root_dependencies.dart';

class TranslationSystem extends System {
  @override
  Future<void> createDependencies(SystemDependencies dependencies) async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }
}
