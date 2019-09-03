import 'package:flutter_test/flutter_test.dart';
import 'package:nuvigator/nuvigator.dart';
import 'package:nuvigator/src/routers/simple_router.dart';
import 'package:nuvigator/src/screen.dart';
import 'package:nuvigator/src/screen_types/cupertino_screen_type.dart';
import 'package:nuvigator/src/screen_types/material_screen_type.dart';

class TestRouter extends SimpleRouter {
  @override
  Map<String, Screen<Object>> get screensMap => {
        'firstScreen': Screen.material((sc) => null),
        'secondScreen': Screen.cupertino((sc) => null),
      };

  @override
  Map<String, String> get deepLinksMap => {
        'test/simple': 'firstScreen',
        'test/:id/params': 'secondScreen',
      };
}

class TestRouterWPrefix extends TestRouter {
  @override
  String get deepLinkPrefix => 'prefix/';
}

final testRouter = TestRouter();
final testRouterWPrefix = TestRouterWPrefix();

void main() {
  group('getScreen', () {
    test('finds the correct screen for `firstScreen`', () {
      expect(testRouter.getScreen(routeName: 'firstScreen').screenType,
          materialScreenType);
    });

    test('finds the correct screen for `secondScreen`', () {
      expect(testRouter.getScreen(routeName: 'secondScreen').screenType,
          cupertinoScreenType);
    });

    test('returns null if the screen is not found', () {
      expect(testRouter.getScreen(routeName: 'notFound'), null);
    });
  });

  group('getDeepLinkPrefix', () {
    test('if no deepLinkPrefix is provided, return empty string', () async {
      expect(await testRouter.getDeepLinkPrefix(), '');
    });
    test('if there is a deepLinkPrefix', () async {
      expect(await testRouterWPrefix.getDeepLinkPrefix(), 'prefix/');
    });
  });

  group('getDeepLinkFlow', () {
    test('find route name for a simple deeplink', () async {
      expect(
          await testRouter.getDeepLinkFlowForUrl('test/simple'),
          DeepLinkFlow(
            routeName: 'firstScreen',
            path: 'test/simple',
            template: 'test/simple',
          ));
    });

    test('find route name for a deeplink with path params', () async {
      expect(
          await testRouter.getDeepLinkFlowForUrl('test/123/params'),
          DeepLinkFlow(
            routeName: 'secondScreen',
            path: 'test/123/params',
            template: 'test/:id/params',
          ));
    });

    test('using prefix, finds a route name', () async {
      expect(
          await testRouterWPrefix
              .getDeepLinkFlowForUrl('prefix/test/123/params'),
          DeepLinkFlow(
            routeName: 'secondScreen',
            path: 'prefix/test/123/params',
            template: 'prefix/test/:id/params',
          ));
    });

    test('return a null Future for not found deeplink', () async {
      expect(await testRouter.getDeepLinkFlowForUrl('not/found'), null);
    });
  });
}
