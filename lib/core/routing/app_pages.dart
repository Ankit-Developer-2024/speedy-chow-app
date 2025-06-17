import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/auth/presentation/views/forgot_password_view.dart';
import 'package:speedy_chow/features/auth/presentation/views/login_view.dart';
import 'package:speedy_chow/features/auth/presentation/views/register_view.dart';
import 'package:speedy_chow/features/auth/presentation/views/reset_password_view.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:speedy_chow/features/cart/presentation/view/cart_view.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';
import 'package:speedy_chow/features/home/presentation/view/home_main_navigation_view.dart';
import 'package:speedy_chow/features/home/presentation/view/home_product_detail_view.dart';
import 'package:speedy_chow/features/home/presentation/view/home_view.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/view/personal_data_view.dart';
import 'package:speedy_chow/features/profile/presentation/view/profile_view.dart';
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
      ),
      GoRoute(
        name: AppRoutes.oneTime,
        path: '/one-time',
        builder: (context, state) => OneTimeUi(),
      ),
      GoRoute(
        name: AppRoutes.login,
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: LoginView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.register,
        path: '/register',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: RegisterView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.forgotPassword,
        path: '/${AppRoutes.forgotPassword}',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: ForgotPasswordView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.resetPassword,
        path: '/${AppRoutes.resetPassword}',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: ResetPasswordView(),
        ),
      ),

      // GoRoute(
      //   name: AppRoutes.homeMainNavigation,
      //   path: '/${AppRoutes.homeMainNavigation}',
      //   builder: (context, state) =>
      //       BlocProvider(
      //         create: (context) => getIt<HomeBloc>(),
      //         child: HomeMainNavigationView(),
      //       ),
      // ),
      ShellRoute(
        builder: (context, state, child) {
          return HomeMainNavigationView(child: child);
        },
        routes: [
          GoRoute(
            name: AppRoutes.home,
            path: '/${AppRoutes.home}',
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<HomeBloc>(),
              child: HomeView(),
            ),
          ),
          GoRoute(
            name: AppRoutes.cart,
            path: '/${AppRoutes.cart}',
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<CartBloc>(),
              child: CartView(),
            ),
          ),
          GoRoute(
            name: AppRoutes.profile,
            path: '/${AppRoutes.profile}',
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<ProfileBloc>(),
              child: ProfileView(),
            ),
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.productDetails,
        path: '/${AppRoutes.productDetails}',
        builder: (context, state) => BlocProvider.value(
          value: state.extra as HomeBloc,
          child: HomeProductDetailView(),
        ),
      ),

      GoRoute(
        name: AppRoutes.personalData,
        path: '/${AppRoutes.personalData}',
        builder: (context, state) => BlocProvider.value(
          value: state.extra as ProfileBloc,
          child: PersonalDataView(),
        ),
      ),
    ],
    errorBuilder: (context, state) => LoginView(),
  );
}
