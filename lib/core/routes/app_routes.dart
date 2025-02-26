import 'package:demo_course_video/core/routes/route_name.dart';
import 'package:demo_course_video/presentation/screens/home/home_screen.dart';
import 'package:demo_course_video/presentation/screens/video-player/video_player_screen.dart';
import 'package:demo_course_video/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
class AppRoutes {
  static final GoRouter router = GoRouter(
    // navigatorKey: rootNavigatorKey,
    // initialLocation: RouteName.splashscreen,
    routes: [
      GoRoute(
        path: RouteName.splashscreen,
        name: RouteName.splashscreen,
        pageBuilder: (context, state) {
          return customPageRouteBuilder(
            const SplashScreen(),
            state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
          );
        }
      ),

      GoRoute(
        path: "/${RouteName.homescreen}",
        name: RouteName.homescreen,
        pageBuilder: (context, state) {
          return customPageRouteBuilder(
            const HomeScreen(),
            state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
          );
        }
      ),

      GoRoute(
        name: RouteName.videoPlayerscreen,
        path: "/${RouteName.videoPlayerscreen}",
        pageBuilder: (context, state) {
          return customPageRouteBuilder(
            const VideoPlayerScreen(),
            state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
          );
        },
      ),
    ]
  );
}

CustomTransitionPage customPageRouteBuilder(Widget page, LocalKey pageKey, {required Duration transitionDuration}) {
  return CustomTransitionPage(
    key: pageKey,
    child: page,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
    transitionDuration: transitionDuration,
  );
}