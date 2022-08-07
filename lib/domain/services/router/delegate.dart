import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/features/question_page/question_page.dart';
import 'package:quiz_app/features/result_page/result_page.dart';

import 'package:quiz_app/features/start_page/start_page.dart';
import 'transition_delegate.dart';

part 'information_parser.dart';
part 'route_constants.dart';

class AppRouterDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final _pages = <Page>[];

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  List<Page> get currentConfiguration => List.of(_pages);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
      transitionDelegate: const AppTransitionDelegate(),
    );
  }

  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }

    return _confirmAppExit();
  }

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) {
    _setPath(
      configuration
          .map((routeSettings) => _createPage(RoutesArgs.fromRouteSettings(routeSettings)))
          .toList(),
    );
    return Future.value(null);
  }

  void push(Routes route, {Object? args}) {
    _pages.add(_createPage(RoutesArgs(route, arguments: args)));
    notifyListeners();
  }

  void pushAndReplace(Routes route, {Object? args}) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    _pages.add(_createPage(RoutesArgs(route, arguments: args)));
    notifyListeners();
  }

  Future<void> newRoutesPath(List<Routes> routesPath, {Object? args}) async {
    await setNewRoutePath(
      routesPath
          .map((e) => RouteSettings(name: RouteConstants.pagesPath[e], arguments: args))
          .toList(),
    );
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;

    popRoute();
    return true;
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);

    // if (_pages.first.name != RouteConstants.pagesPath[initRout]) {
    //   _pages.insert(0, _createPage(RoutesArgs(initRout)));
    // }
    notifyListeners();
  }

  MaterialPage _createPage(RoutesArgs routeSettings) {
    return MaterialPage(
      child: RouteConstants.router(routeSettings.name, args: routeSettings.arguments),
      key: Key(routeSettings.toString()) as LocalKey,
      name: routeSettings.name.name,
      arguments: routeSettings.arguments,
    );
  }

  Future<bool> _confirmAppExit() async {
    final result = await showDialog<bool>(
        context: navigatorKey!.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Text('Выход из приложения', style: Theme.of(context).primaryTextTheme.headline2),
            content: Text('Вы действительно хотите выйти из приложения?',
                style: Theme.of(context).primaryTextTheme.titleMedium),
            actions: [
              TextButton(
                child: Text('Нет',
                    style: Theme.of(context).primaryTextTheme.button!.copyWith(fontSize: 16)),
                onPressed: () => Navigator.pop(context, true),
              ),
              TextButton(
                child: Text('Да',
                    style: Theme.of(context).primaryTextTheme.button!.copyWith(fontSize: 16)),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          );
        });

    return result ?? true;
  }
}
