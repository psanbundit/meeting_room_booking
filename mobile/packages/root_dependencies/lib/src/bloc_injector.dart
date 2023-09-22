part of root_dependencies;

typedef InjectBloc = void Function<T extends BlocBase>(
  T bloc, {
  bool lazy,
});

abstract class BlocInjector {
  injectBlocs(InjectBloc inject);
}
