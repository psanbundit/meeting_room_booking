import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric chill() {
  return and<FlutterWorld>(
    'I chill out a bit',
    (context) async {
      Future.delayed(const Duration(milliseconds: 5000));
    },
  );
}
