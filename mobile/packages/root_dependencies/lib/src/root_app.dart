part of root_dependencies;

class RootApp extends StatefulWidget {
  final Widget Function() view;
  final Widget Function()? loadingView;
  final System Function() system;
  final BlocInjector blocInjector;
  final LocalizationConfig localization;
  final Map<String, dynamic> Function()? args;

  const RootApp({
    Key? key,
    required this.view,
    this.loadingView,
    required this.system,
    required this.blocInjector,
    required this.localization,
    this.args,
  }) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  bool readyToBuild = false;
  final List<BlocProvider> providers = [];
  final SystemDependencies dependencies = SystemDependencies();
  late SystemContext systemContext;

  @override
  void initState() {
    super.initState();
    startDependencies();
  }

  Future<void> startDependencies() async {
    systemContext = SystemContext(
      system: widget.system(),
      args: widget.args?.call() ?? {},
      dependencies: dependencies,
    );
    await systemContext.start();
    widget.blocInjector.injectBlocs(<T extends BlocBase>(
      T bloc, {
      bool lazy = false,
    }) {
      // register blocs to system dependencies
      dependencies.add<T>(bloc, lazy: lazy);
      providers.add(BlocProvider<T>.value(value: bloc));
      debugPrint('✅ <${bloc.runtimeType}> >> [BlocProvider]');
    });

    await widget.localization.start();

    setState(() {
      readyToBuild = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (readyToBuild) {
      return EasyLocalization(
        supportedLocales: widget.localization.supportedLocales,
        path: "translations",
        fallbackLocale: widget.localization.supportedLocales.first,
        assetLoader: widget.localization.assetLoader,
        child: MultiBlocProvider(
          providers: providers,
          child: widget.view(),
        ),
      );
    }

    return widget.loadingView != null ? widget.loadingView!() : const Scaffold();
  }
}
