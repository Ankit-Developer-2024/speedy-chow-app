import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';
import 'package:speedy_chow/features/home/presentation/widgets/home_category_view.dart';
import 'package:speedy_chow/features/home/presentation/widgets/home_products_view.dart';
import 'package:speedy_chow/features/home/presentation/widgets/home_top_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<HomeBloc>();
    _homeBloc
      ..add(HomeFetchAllProductEvent())
      ..add(HomeFetchAllCategoryEvent());
    context.read<AuthBloc>().add(AuthUserEvent());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          context.read<HomeBloc>().add(HomeFetchAllProductEvent());
          context.read<AuthBloc>().add(AuthUserEvent());
          context.read<HomeBloc>().add(HomeFetchAllCategoryEvent());
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: HomeTopView()),

            SliverToBoxAdapter(child: HomeCategoryView()),

            HomeProductsView(),
          ],

          //category
        ),
      ),
    );
  }
}
