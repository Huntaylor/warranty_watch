import 'package:warranty_keeper/app_library.dart';

/// Abstraction above Navigator that makes our code more testable.
///
/// Forwards calls to the Navigator.
///
/// Other Navigation controllers should be created to be called for specific flows.
class AppNavigator {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  AppNavigator._();

  static final AppNavigator _instance = AppNavigator._();

  static AppNavigator get instance {
    return _instance;
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return _asMicrotask(
      () => rootNavigatorKey.currentState!.pushNamed<T>(
        routeName,
        arguments: arguments,
      ),
    );
  }

  Future<T?> pushReplacementNamed<T, TO>(String routeName,
      {TO? result, Object? arguments}) {
    return _asMicrotask(
      () => rootNavigatorKey.currentState!.pushReplacementNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      ),
    );
  }

  Future<T?> pushNamedAndClearStack<T>(String routeName, {Object? arguments}) {
    return _asMicrotask(
      () => rootNavigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
        routeName,
        (route) => false,
      ),
    );
  }

  Future<void> pop<T>([T? result]) {
    return _asMicrotask(
      () async => rootNavigatorKey.currentState!.pop<T>(result),
    );
  }

  Future<void> maybePop<T>([T? result]) {
    return _asMicrotask(
      () async => rootNavigatorKey.currentState!.maybePop<T>(result),
    );
  }

  Future<void> popUntil(bool Function(Route<dynamic>) predicate) {
    return _asMicrotask(
      () async => rootNavigatorKey.currentState!.popUntil(predicate),
    );
  }

  Future<void> popUntilNamed(String routeName) {
    return _asMicrotask(
      () async => rootNavigatorKey.currentState!.popUntil(
        (route) => route.settings.name == routeName,
      ),
    );
  }

  Future<T?> pushNamedAndRemoveUntilNamed<T>(String routeName,
      {required String untilRouteName, Object? arguments}) {
    return _asMicrotask(
      () => rootNavigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
        routeName,
        (route) => route.settings.name == untilRouteName,
        arguments: arguments,
      ),
    );
  }

  Future<T?> _asMicrotask<T>(Future<T?> Function() navigateEvent) async {
    return Future.microtask(() async => navigateEvent());
  }
}
