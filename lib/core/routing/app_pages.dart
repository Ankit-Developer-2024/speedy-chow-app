import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/auth/presentation/views/forgot_password_view.dart';
import 'package:speedy_chow/features/auth/presentation/views/login_view.dart';
import 'package:speedy_chow/features/auth/presentation/views/register_view.dart';
import 'package:speedy_chow/features/auth/presentation/views/reset_password_view.dart';
import 'package:speedy_chow/features/splash/presentation/view/one_time_ui.dart';
import 'package:speedy_chow/features/splash/presentation/view/splash_view.dart';
import 'package:speedy_chow/init_dependencies.dart';

class AppPages {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (context, state) => SplashView(),
      ), GoRoute(
        name: AppRoutes.oneTime,
        path: '/one-time',
        builder: (context, state) => OneTimeUi(),
      ),
      GoRoute(
        name: AppRoutes.login,
        path: '/login',
        builder: (context, state) =>
            BlocProvider(
              create: (context) => getIt<AuthBloc>(),
              child: LoginView(),
            ),
      ),
      GoRoute(
        name: AppRoutes.register,
        path: '/register',
        builder: (context, state) =>
            BlocProvider(
              create: (context) =>getIt<AuthBloc>(),
              child: RegisterView(),
            ),
      ),
      GoRoute(
        name: AppRoutes.forgotPassword,
        path: '/${AppRoutes.forgotPassword}',
        builder: (context, state) =>
            BlocProvider(
              create: (context) =>getIt<AuthBloc>(),
              child: ForgotPasswordView(),
            ),
      ),
      GoRoute(
        name: AppRoutes.resetPassword,
        path: '/${AppRoutes.resetPassword}',
        builder: (context, state) =>
            BlocProvider(
              create: (context) =>getIt<AuthBloc>(),
              child: ResetPasswordView(),
            ),
      ),
    ],
    errorBuilder: (context, state) => LoginView(),
  );
}
