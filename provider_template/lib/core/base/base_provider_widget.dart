import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This class  will handle passing the Provider down to the resulting widget(s)
// and giving us the onInit callback for initialisation before the UI is rendered.

abstract class BaseProviderWidget<T> extends Widget {
  const BaseProviderWidget({super.key});

  // Define that we want to get back a type of T when building
  // Make it abstract so that we have to override, like a stateless or stateful widget.
  @protected
  Widget build(BuildContext context, T provider);

  @override
  DataProviderElement<T> createElement() => DataProviderElement<T>(this);
}

class DataProviderElement<T> extends ComponentElement {
  /// Creates an element that uses the given widget as its configuration.
  DataProviderElement(BaseProviderWidget super.widget);

  // When executing the above build method, we pass back the model we get from Provider.
  @override
  Widget build() =>
      (widget as BaseProviderWidget).build(this, Provider.of<T>(this));

  @override
  void update(BaseProviderWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}

abstract class BaseProviderWidget2<A, B> extends Widget {
  const BaseProviderWidget2({super.key});

  // Define that we want to get back a type of T when building
  // Make it abstract so that we have to override, like a stateless or stateful widget.
  @protected
  Widget build(BuildContext context, A provider, B provider2);

  @override
  DataProviderElement2<A, B> createElement() =>
      DataProviderElement2<A, B>(this);
}

class DataProviderElement2<A, B> extends ComponentElement {
  /// Creates an element that uses the given widget as its configuration.
  DataProviderElement2(BaseProviderWidget2 super.widget);

  // When executing the above build method, we pass back the model we get from Provider.
  @override
  Widget build() => (widget as BaseProviderWidget2)
      .build(this, Provider.of<A>(this), Provider.of<B>(this));

  @override
  void update(BaseProviderWidget2 newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}
