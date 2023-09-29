import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric enterText() {
  return then2<String, String, FlutterWorld>(
    'I fill {string} with {string}',
    (tag, text, context) async {
      var finder = find.byValueKey(tag);
      await Future.delayed(const Duration(milliseconds: 1000));
      context.world.driver!.enterText(text);
    },
  );
}
