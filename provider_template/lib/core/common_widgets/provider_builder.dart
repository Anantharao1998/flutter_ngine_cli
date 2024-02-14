import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/dependency_injection.dart';
import 'package:provider/provider.dart';

class ProviderViewBuilder<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;
  final Function(AppLifecycleState, T)? didChangeAppLifeCycle;
  final Function(T provider)? onInit;
  final T? provider;

  const ProviderViewBuilder({
    required this.builder,
    Key? key,
    this.didChangeAppLifeCycle,
    this.onInit,
    this.provider,
  }) : super(key: key);

  @override
  State<ProviderViewBuilder> createState() => _ProviderViewBuilderState<T>();
}

class _ProviderViewBuilderState<T extends ChangeNotifier>
    extends State<ProviderViewBuilder<T>> with WidgetsBindingObserver {
  late T model;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.didChangeAppLifeCycle?.call(state, model);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    model = widget.provider ?? locator<T>();
    widget.onInit?.call(model);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    return widget.provider != null
        ? ChangeNotifierProvider.value(
            value: widget.provider,
            child: widget.builder(context, widget.provider!),
          )
        : ChangeNotifierProvider(
            create: (context) => model,
            builder: (ctx, vm) {
              return widget.builder(ctx, model);
            },
          );
  }
}

class ProviderViewBuilder2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A provider1, B provider2) builder;
  final A? model1;
  final B? model2;
  final Widget? child;
  final Function(A model1, B model2)? onModelReady;

  const ProviderViewBuilder2({
    required this.builder,
    this.model1,
    this.model2,
    Key? key,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  @override
  State<ProviderViewBuilder2> createState() =>
      _ProviderViewBuilder2State<A, B>();
}

class _ProviderViewBuilder2State<A extends ChangeNotifier,
    B extends ChangeNotifier> extends State<ProviderViewBuilder2<A, B>> {
  late A model1;
  late B model2;

  @override
  void initState() {
    model1 = widget.model1 ?? locator<A>();
    model2 = widget.model2 ?? locator<B>();
    widget.onModelReady?.call(model1, model2);
    super.initState();
  }

  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
      ],
      builder: (context, child) {
        return widget.builder(context, model1, model2);
      },
    );
  }
}
