import 'package:flutter/widgets.dart';
import 'package:nuvigator/nuvigator.dart';

class TestRouter extends BaseRouter {
  @override
  Map<String, ScreenRoute> get screensMap => {
        'firstScreen': ScreenRoute(
          builder: (sc) => null,
          deepLink: 'test/simple',
          debugKey: 'testRouterFirstScreen',
          screenType: materialScreenType,
        ),
        'secondScreen': ScreenRoute(
          builder: (sc) => null,
          deepLink: 'test/:id/params',
          debugKey: 'testRouterSecondScreen',
          screenType: materialScreenType,
        ),
      };
}

class TestRouterWPrefix extends TestRouter {
  @override
  String get deepLinkPrefix => 'prefix/';
}

class GroupTestRouter extends BaseRouter {
  @override
  String get deepLinkPrefix => 'group/';

  @override
  List<Router> get routers => [
        testRouter,
      ];

  @override
  Map<String, ScreenRoute> get screensMap => {
        'firstScreen': ScreenRoute(
          builder: (sc) => null,
          debugKey: 'groupRouterFirstScreen',
          screenType: cupertinoScreenType,
          deepLink: 'route/test',
        ),
      };
}

final testRouter = TestRouter();
final testRouterWPrefix = TestRouterWPrefix();
final testGroupRouter = GroupTestRouter();

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
