import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric tap() {
  return when1<String, FlutterWorld>(
    'I tap the {string}',
    (key, context) async {
      var finder = find.byValueKey(key);
      await Future.delayed(const Duration(milliseconds: 1000));
      context.world.driver!.tap(finder);
    },
  );
}
