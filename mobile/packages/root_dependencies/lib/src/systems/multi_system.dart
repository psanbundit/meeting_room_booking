part of root_dependencies;

abstract class MultiSystem extends System {
  final List<System> systems;

  MultiSystem({required this.systems});

  @override
  void setContext(SystemContext context) {
    super.setContext(context);
    for (final system in systems) {
      system.setContext(context);
    }
  }

  @override
  Future<void> createDependencies(SystemDependencies dependencies) async {
    for (final system in systems) {
      await system.createDependencies(dependencies);
      debugPrint('✅ <${system.runtimeType}> >> [Created]');
    }
  }
}
