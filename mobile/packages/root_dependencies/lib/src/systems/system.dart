part of root_dependencies;

abstract class System {
  late SystemContext _context;

  SystemDependencies get dependencies => _context.dependencies;
  Map<String, dynamic> get args => _context.args;

  void setContext(SystemContext context) {
    _context = context;
  }

  Future<void> createDependencies(SystemDependencies dependencies);
}
