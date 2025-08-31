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
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';
import 'package:speedy_chow/features/payment_method/presentation/view/create_order_view.dart';
import 'package:speedy_chow/features/payment_method/presentation/view/payment_method_view.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';
import 'package:speedy_chow/features/home/presentation/view/home_main_navigation_view.dart';
import 'package:speedy_chow/features/product_details/presentation/bloc/product_detail_bloc.dart';
import 'package:speedy_chow/features/product_details/presentation/view/home_product_detail_view.dart';
import 'package:speedy_chow/features/home/presentation/view/home_view.dart';
import 'package:speedy_chow/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:speedy_chow/features/profile/presentation/view/account_deletion_view.dart';
import 'package:speedy_chow/features/profile/presentation/view/help_center_view.dart';
import 'package:speedy_chow/features/profile/presentation/view/personal_data_view.dart';
import 'package:speedy_chow/features/profile/presentation/view/profile_view.dart';
import 'package:speedy_chow/features/profile/presentation/view/settings_view.dart';
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
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        name: AppRoutes.register,
        path: '/register',
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        name: AppRoutes.forgotPassword,
        path: '/${AppRoutes.forgotPassword}',
        builder: (context, state) => ForgotPasswordView(),
      ),
      GoRoute(
        name: AppRoutes.resetPassword,
        path: '/${AppRoutes.resetPassword}',
        builder: (context, state) => ResetPasswordView(),
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
              create: (context) => getIt<HomeBloc>()..add(HomeFetchAllProductEvent()),
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
        builder: (context, state) {
         return BlocProvider(
            create:(context)=> getIt<ProductDetailBloc>(),
            child: HomeProductDetailView(),
         );
        }
      ),

      GoRoute(
        name: AppRoutes.personalData,
        path: '/${AppRoutes.personalData}',
        builder: (context, state) => BlocProvider.value(
          value: state.extra as ProfileBloc,
          child: PersonalDataView(),
        ),
      ),

      GoRoute(
        name: AppRoutes.settings,
        path: '/${AppRoutes.settings}',
        builder: (context, state) => BlocProvider.value(
          value: state.extra as ProfileBloc,
          child: SettingsView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.helpCenter,
        path: '/${AppRoutes.helpCenter}',
        builder: (context, state) => BlocProvider.value(
          value: state.extra as ProfileBloc,
          child: HelpCenterView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.requestAccountDeletion,
        path: '/${AppRoutes.requestAccountDeletion}',
        builder: (context, state) => BlocProvider.value(
          value: state.extra as ProfileBloc,
          child: AccountDeletionView(),
        ),
      ),
      GoRoute(
        name: AppRoutes.paymentMethod,
        path: '/${AppRoutes.paymentMethod}',
        builder: (context, state) => BlocProvider(
          create: (context)=> getIt<PaymentMethodBloc>(),
          child: PaymentMethodView(),
        ),
      ),

      GoRoute(
        name: AppRoutes.createOrder,
        path: '/${AppRoutes.createOrder}',
        builder: (context, state) => BlocProvider.value(
          value: state.extra as PaymentMethodBloc,
          child: CreateOrderView(),
        ),
      ),


    ],
    errorBuilder: (context, state) => LoginView(),
  );
}
