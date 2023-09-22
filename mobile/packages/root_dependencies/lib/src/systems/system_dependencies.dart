part of root_dependencies;

class SystemDependencies {
  void add<T extends Object>(
    T instance, {
    bool lazy = false,
  }) {
    if (lazy) {
      GetIt.I.registerLazySingleton<T>(() => instance);
    } else {
      GetIt.I.registerSingleton<T>(instance);
    }
    debugPrint(
      "✅ <${instance.runtimeType}> >> [SystemDependencies] ${lazy ? '::lazy' : ''}",
    );
  }

  static T of<T extends Object>() {
    return GetIt.I<T>();
  }
}
