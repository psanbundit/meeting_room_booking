import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric foundText() {
  return then1<String, FlutterWorld>(
    'I found text with {string}',
    (text, context) async {
      final textFinder = find.text(text);
      await context.world.driver!.waitFor(textFinder);
    },
  );
}