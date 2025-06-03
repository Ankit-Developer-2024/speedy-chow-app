import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/features/auth/presentation/views/login_view.dart';
import 'package:speedy_chow/features/splash/presentation/view/one_time_ui.dart';
import 'package:speedy_chow/features/splash/presentation/view/splash_view.dart';

class AppPages {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name:'splash',
        path: '/',
        builder: (context, state) => SplashView(),
      ), GoRoute(
        name:'one-time',
        path: '/one-time',
        builder: (context, state) => OneTimeUi(),
      ),
     GoRoute(
      name:'login',
      path: '/login',
      builder: (context, state) => LoginView(),
      ),
  ],
  errorBuilder: (context, state) => LoginView(),
  );
}
