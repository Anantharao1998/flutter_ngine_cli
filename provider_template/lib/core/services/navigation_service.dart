import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop({dynamic result}) {
    return _navigationKey.currentState?.pop(result);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndPushTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  /// if removeUntilNamed is null,
  /// remove all screen and make [pushNamed] screen become root
  Future<dynamic> pushAndRemoveUntil(String pushNamed,
      {String? removeUntilNamed, Object? arguments}) async {
    return removeUntilNamed != null
        ? _navigationKey.currentState!.pushNamedAndRemoveUntil(
            pushNamed, ModalRoute.withName(removeUntilNamed),
            arguments: arguments)
        : _navigationKey.currentState!.pushNamedAndRemoveUntil(
            pushNamed, (route) => false,
            arguments: arguments);
  }

  void popUntil({String? popUntilNamed}) {
    if (popUntilNamed != null) {
      _navigationKey.currentState!.popUntil(ModalRoute.withName(popUntilNamed));
    } else {
      _navigationKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}

final NavigationService navigationService = NavigationService();
