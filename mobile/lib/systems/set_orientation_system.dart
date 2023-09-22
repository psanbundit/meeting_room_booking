import 'package:flutter/services.dart';
import 'package:root_dependencies/root_dependencies.dart';

class SetOrientationSystem extends System {
  @override
  Future<void> createDependencies(SystemDependencies dependencies) async {
    await Future.delayed(Duration.zero);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
