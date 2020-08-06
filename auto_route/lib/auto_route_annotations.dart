import 'package:meta/meta.dart';

abstract class RouteType {
  const RouteType._(this.fullscreenDialog, this.maintainState);

  /// passed to the fullscreenDialog property in [MaterialPageRoute]
  final bool fullscreenDialog;

  /// passed to the maintainState property in [MaterialPageRoute]
  final bool maintainState;
}

class MaterialRouteType extends RouteType {
  const MaterialRouteType({
    bool fullscreenDialog,
    bool maintainState,
  }) : super._(fullscreenDialog, maintainState);
}

class CupertinoRouteType extends RouteType {
  const CupertinoRouteType({
    this.title,
    bool fullscreenDialog,
    bool maintainState,
  }) : super._(fullscreenDialog, maintainState);

  /// passed to the title property in [CupertinoPageRoute]
  final String title;
}

class CustomRouteType extends RouteType {
  const CustomRouteType({
    bool fullscreenDialog,
    bool maintainState,
    this.transitionsBuilder,
    this.durationInMilliseconds,
    this.opaque,
    this.barrierDismissible,
  }) : super._(fullscreenDialog, maintainState);

  /// this builder function is passed to the transition builder
  /// function in [PageRouteBuilder]
  ///
  /// I couldn't type this function from here, but it should match
  /// typedef [RouteTransitionsBuilder] = Widget Function(BuildContext context, Animation<double> animation,
  /// Animation<double> secondaryAnimation, Widget child);
  ///
  /// you should only reference the function so
  /// the generator can import it into router_base.dart
  final Function transitionsBuilder;

  /// route transition duration in milliseconds
  /// is passed to [PageRouteBuilder]
  /// this property is ignored unless a [transitionBuilder] is provided
  final int durationInMilliseconds;

  /// passed to the opaque property in [PageRouteBuilder]
  final bool opaque;

  /// passed to the barrierDismissible property in [PageRouteBuilder]
  final bool barrierDismissible;
}

class AdaptiveRouteType extends RouteType {
  const AdaptiveRouteType({
    bool fullscreenDialog,
    bool maintainState,
    this.cupertinoPageTitle,
  }) : super._(fullscreenDialog, maintainState);

  /// passed to the title property in [CupertinoPageRoute]
  final String cupertinoPageTitle;
}

class AutoRouter {
  const AutoRouter({
    this.generateNavigationHelperExtension,
    this.routesClassName,
    this.pathPrefix,
    this.routes,
    this.defaultRouteType,
    this.preferRelativeImports,
  }) : assert(routes != null);

  // if true a Navigator extension will be generated with
  // helper push methods of all routes
  final bool generateNavigationHelperExtension;

  // defaults to 'Routes'
  final String routesClassName;

  //This is the prefix for each Route String that is generated
  // initial routes will always be named '/'
  // defaults to '/'
  final String pathPrefix;

  /// if true relative imports will be generated
  /// when possible
  /// defaults to true
  final bool preferRelativeImports;

  final List<AutoRoute> routes;

  final RouteType defaultRouteType;
}

// Defaults created routes to MaterialPageRoute unless
// overridden by AutoRoute annotation
@Deprecated('use AutoRouter with a MaterialRouteType as defaultRouteType')
class MaterialAutoRouter extends AutoRouter implements MaterialRouteType {
  const MaterialAutoRouter({
    bool generateNavigationHelperExtension,
    String routesClassName,
    String pathPrefix,
    bool preferRelativeImports,
    @required List<AutoRoute> routes,
  }) : super(
          generateNavigationHelperExtension: generateNavigationHelperExtension,
          routesClassName: routesClassName,
          pathPrefix: pathPrefix,
          routes: routes,
          preferRelativeImports: preferRelativeImports,
        );

  @override
  bool get fullscreenDialog => false;

  @override
  bool get maintainState => false;
}

// Defaults created routes to CupertinoPageRoute unless
// overridden by AutoRoute annotation
@Deprecated('use AutoRouter with a CupertinoRouteType as defaultRouteType')
class CupertinoAutoRouter extends AutoRouter implements CupertinoRouteType {
  const CupertinoAutoRouter({
    bool generateNavigationHelperExtension,
    String routesClassName,
    String pathPrefix,
    bool preferRelativeImports,
    @required List<AutoRoute> routes,
  }) : super(
          generateNavigationHelperExtension: generateNavigationHelperExtension,
          routesClassName: routesClassName,
          pathPrefix: pathPrefix,
          routes: routes,
          preferRelativeImports: preferRelativeImports,
        );

  @override
  bool get fullscreenDialog => false;

  @override
  bool get maintainState => false;

  @override
  String get title => null;
}

@Deprecated('use AutoRouter with a AdaptiveRouteType as defaultRouteType')
class AdaptiveAutoRouter extends AutoRouter {
  const AdaptiveAutoRouter({
    bool generateNavigationHelperExtension,
    String routesClassName,
    String pathPrefix,
    bool preferRelativeImports,
    @required List<AutoRoute> routes,
  }) : super(
          generateNavigationHelperExtension: generateNavigationHelperExtension,
          routesClassName: routesClassName,
          pathPrefix: pathPrefix,
          routes: routes,
          preferRelativeImports: preferRelativeImports,
        );
}

// Defaults created routes to PageRouteBuilder unless
// overridden by AutoRoute annotation
@Deprecated('use AutoRouter with a CustomRouteType as defaultRouteType')
class CustomAutoRouter extends AutoRouter implements CustomRouteType {
  /// this builder function is passed to the transition builder
  /// function in [PageRouteBuilder]
  ///
  /// I couldn't type this function from here, but it should match
  /// typedef [RouteTransitionsBuilder] = Widget Function(BuildContext context, Animation<double> animation,
  /// Animation<double> secondaryAnimation, Widget child);
  ///
  /// you should only reference the function so
  /// the generator can import it into router_base.dart
  @override
  final Function transitionsBuilder;

  /// route transition duration in milliseconds
  /// is passed to [PageRouteBuilder]
  /// this property is ignored unless a [transitionBuilder] is provided
  @override
  final int durationInMilliseconds;

  /// passed to the opaque property in [PageRouteBuilder]
  @override
  final bool opaque;

  /// passed to the barrierDismissible property in [PageRouteBuilder]
  @override
  final bool barrierDismissible;

  const CustomAutoRouter({
    this.transitionsBuilder,
    this.barrierDismissible,
    this.durationInMilliseconds,
    this.opaque,
    bool generateNavigationHelperExtension,
    String routesClassName,
    String pathPrefix,
    @required List<AutoRoute> routes,
    bool preferRelativeImports,
  }) : super(
          generateNavigationHelperExtension: generateNavigationHelperExtension,
          routesClassName: routesClassName,
          pathPrefix: pathPrefix,
          routes: routes,
          preferRelativeImports: preferRelativeImports,
        );

  @override
  bool get fullscreenDialog => false;

  @override
  bool get maintainState => false;
}

// [T] is the results type returned
/// from this page route MaterialPageRoute<T>()
/// defaults to dynamic

class AutoRoute<T> {
  // initial route will have an explicit name of "/"
  // there could be only one initial route per navigator.
  final bool initial;

  /// passed to the fullscreenDialog property in [MaterialPageRoute]
  final bool fullscreenDialog;

  /// passed to the maintainState property in [MaterialPageRoute]
  final bool maintainState;
  final List<AutoRoute> children;

  /// route path name which will be assigned to the given variable name
  /// const homeScreen = '[path]';
  /// if null a kabab cased variable name
  /// prefixed with '/' will be used;
  /// homeScreen -> home-screen

  final String path;
  final String name;

  final Type page;
  final RouteType type;

  final List<Type> guards;

  const AutoRoute({
    @required this.page,
    this.initial,
    this.guards,
    @deprecated this.fullscreenDialog,
    @deprecated this.maintainState,
    this.path,
    this.name,
    this.children,
    this.type,
  });
}

@Deprecated("use AutoRoute with a MaterialRouteType")
class MaterialRoute<T> extends AutoRoute<T> {
  const MaterialRoute(
      {String path,
      @required Type page,
      bool initial,
      bool fullscreenDialog,
      bool maintainState,
      String name,
      List<Type> guards,
      List<AutoRoute> children})
      : super(
          page: page,
          guards: guards,
          initial: initial,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          path: path,
          children: children,
          name: name,
        );
}

// forces usage of CupertinoPageRoute instead of MaterialPageRoute
@Deprecated("use AutoRoute with a CupertinoRouteType")
class CupertinoRoute<T> extends AutoRoute<T> {
  /// passed to the title property in [CupertinoPageRoute]
  final String title;

  const CupertinoRoute(
      {bool initial,
      bool fullscreenDialog,
      bool maintainState,
      String path,
      this.title,
      String name,
      @required Type page,
      List<Type> guards,
      List<AutoRoute> children})
      : super(
            initial: initial,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            path: path,
            name: name,
            page: page,
            guards: guards,
            children: children);
}

@Deprecated("use AutoRoute with a AdaptiveRouteType")
class AdaptiveRoute<T> extends AutoRoute<T> {
  const AdaptiveRoute(
      {bool initial,
      bool fullscreenDialog,
      bool maintainState,
      String name,
      String path,
      Type returnType,
      this.cupertinoPageTitle,
      @required Type page,
      List<Type> guards,
      List<AutoRoute> children})
      : super(
            initial: initial,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            path: path,
            name: name,
            page: page,
            guards: guards,
            children: children);

  /// passed to the title property in [CupertinoPageRoute]
  final String cupertinoPageTitle;
}

@Deprecated("use AutoRoute with a CustomRouteType")
class CustomRoute<T> extends AutoRoute<T> {
  /// this builder function is passed to the transition builder
  /// function in [PageRouteBuilder]
  ///
  /// I couldn't type this function from here, but it should match
  /// typedef [RouteTransitionsBuilder] = Widget Function(BuildContext context, Animation<double> animation,
  /// Animation<double> secondaryAnimation, Widget child);
  ///
  /// you should only reference the function so
  /// the generator can import it into router_base.dart
  final Function transitionsBuilder;

  /// route transition duration in milliseconds
  /// is passed to [PageRouteBuilder]
  /// this property is ignored unless a [transitionBuilder] is provided
  final int durationInMilliseconds;

  /// passed to the opaque property in [PageRouteBuilder]
  final bool opaque;

  /// passed to the barrierDismissible property in [PageRouteBuilder]
  final bool barrierDismissible;

  const CustomRoute({
    bool initial,
    bool fullscreenDialog,
    bool maintainState,
    String name,
    String path,
    @required Type page,
    List<Type> guards,
    List<AutoRoute> children,
    this.transitionsBuilder,
    this.durationInMilliseconds,
    this.opaque,
    this.barrierDismissible,
  }) : super(
            initial: initial,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            path: path,
            name: name,
            page: page,
            guards: guards,
            children: children);
}

class PathParam {
  final String name;

  const PathParam([this.name]);
}

const pathParam = PathParam();

class QueryParam {
  final String name;

  const QueryParam([this.name]);
}

const queryParam = QueryParam();
