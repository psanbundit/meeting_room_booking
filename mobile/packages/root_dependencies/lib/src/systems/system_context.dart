part of root_dependencies;

class SystemContext {
  final System system;
  final Map<String, dynamic> args;
  final SystemDependencies dependencies;

  SystemContext({
    required this.system,
    this.args = const {},
    required this.dependencies,
  });

  Future<void> start() async {
    system.setContext(this);
    await system.createDependencies(dependencies);
  }
}
