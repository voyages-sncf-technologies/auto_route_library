import 'package:auto_route/auto_route_annotations.dart';
import 'package:example/router/route_guards.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/unknown_route.dart';
import '../screens/users/sub/posts_screen.dart';
import '../screens/users/sub/profile_screen.dart';
import '../screens/users/sub/sub/posts_details.dart';
import '../screens/users/sub/sub/posts_home.dart';
import '../screens/users/users_screen.dart';

@AutoRouter(
  generateNavigationHelperExtension: true,
  defaultRouteType: MaterialRouteType(),
  routes: <AutoRoute>[
    MaterialRoute(page: HomeScreen, initial: true, guards: [AuthGuard]),
    AutoRoute<void>(
      path: '/users/:id',
      page: UsersScreen,
      name: 'usersScreen',
      type: MaterialRouteType(fullscreenDialog: true),
      children: [
        AutoRoute(path: '/', page: ProfileScreen),
        AutoRoute(
          path: '/posts',
          page: PostsScreen,
          children: [
            AutoRoute(path: '/', page: PostsHome),
            AutoRoute(path: '/details', page: PostDetails),
          ],
        ),
      ],
    ),
    AutoRoute<bool>(path: '/login', page: LoginScreen),
    AutoRoute(path: '*', page: UnknownRouteScreen)
  ],
)
class $Router {}
