import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric chillFor() {
  return and1<int, FlutterWorld>(
    'I chill out for {int} seconds',
    (seconds, context) async {
      Future.delayed(Duration(seconds: seconds));
    },
  );
}
