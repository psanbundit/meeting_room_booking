import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import '../utils/utils.dart';

class elementLoaded extends Then1WithWorld<String, FlutterWorld> {
  elementLoaded()
      : super(
          StepDefinitionConfiguration()..timeout = const Duration(milliseconds: 2000),
        );

  @override
  Future<void> executeStep(String tag) async {
    await isAppeared(world.driver!, tag);
  }

  @override
  RegExp get pattern => RegExp(r"I should see {string}");
}
