import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/features/home/presentation/widgets/home_category_view.dart';
import 'package:speedy_chow/features/home/presentation/widgets/home_products_view.dart';
import 'package:speedy_chow/features/home/presentation/widgets/home_top_view.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: HomeTopView()),

          SliverToBoxAdapter(child: HomeCategoryView()),

          HomeProductsView(),
        ],

        //category
      ),
    );
  }
}
