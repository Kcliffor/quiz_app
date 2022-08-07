part of 'delegate.dart';

class RouteConstants {
  static Map<Routes, String> pagesPath = {
    Routes.startPage: 'startPage',
    Routes.questionPage: 'questionPage',
    Routes.resultPage: 'resultPage',
  };

  static router(Routes route, {Object? args}) {
    if (route == Routes.startPage) {
      return const StartPage();
    } else if (route == Routes.questionPage) {
      return QuestionPage(args: args);
    } else if (route == Routes.resultPage) {
      return ResultPage(args: args);
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('404')),
        body: const Center(child: Text('Page not found')),
      );
    }
  }
}

enum Routes {
  startPage,
  questionPage,
  resultPage,
}

class RoutesArgs {
  /// Creates data used to construct routes.
  const RoutesArgs(
    this.name, {
    this.arguments,
  });

  RoutesArgs.fromRouteSettings(RouteSettings routeSettings)
      : name = RouteConstants.pagesPath.entries
            .firstWhere(
              (rout) => rout.value == routeSettings.name,
              orElse: () => MapEntry(
                  Routes.startPage, RouteConstants.pagesPath[Routes.startPage] ?? '/splash'),
            )
            .key,
        arguments = routeSettings.arguments;

  /// Creates a copy of this route settings object with the given fields
  /// replaced with the new values.
  RoutesArgs copyWith({
    Routes? name,
    Object? arguments,
  }) {
    return RoutesArgs(
      name ?? this.name,
      arguments: arguments ?? this.arguments,
    );
  }

  final Routes name;

  final Object? arguments;

  @override
  String toString() => '${objectRuntimeType(this, 'RoutesArgs')}("$name", $arguments)';
}
