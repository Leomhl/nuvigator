import 'package:flutter/material.dart';
import 'screen.dart';

class DeepLinkFlow {
  DeepLinkFlow({this.template, this.path, this.routeName});

  final String template;
  final String path;
  final String routeName;

  @override
  bool operator ==(dynamic other) {
    if (other is DeepLinkFlow) {
      return other.routeName == routeName && other.path == path &&
          other.routeName == routeName;
    }
    return false;
  }

}

/// Base Router class. Provide a basic interface to communicate with other Route
/// components.
abstract class Router {
  Screen getScreen({String routeName});

  Future<DeepLinkFlow> getDeepLinkFlowForUrl(String url) => null;
}

/// Application Router class. Provides a basic interface and helper to handle
/// deepLinks and routes.
abstract class AppRouter {
  Future<bool> canOpenDeepLink(Uri url);

  Future<T> openDeepLink<T>(Uri url, [dynamic arguments]);

  Route getRoute(RouteSettings settings);
}
