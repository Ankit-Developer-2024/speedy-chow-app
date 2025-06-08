import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/home/presentation/widgets/home_category_view.dart';
import 'package:speedy_chow/features/home/presentation/widgets/home_products_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Image.asset(getLocalPng("home_view_bg")),
                  Container(
                    height: 260,
                    padding: const EdgeInsets.all(AppDimensions.size_24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocal.yourLocation.getString(context),
                                  style: AppTextStyles.regular20P(
                                    color: AppColors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: AppColors.white,
                                  size: AppDimensions.size_32,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: AppDimensions.spacing_8,
                              children: [
                                IconButton.outlined(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                      BorderSide(color: AppColors.white),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.search_rounded,
                                    color: AppColors.white,
                                    size: AppDimensions.size_24,
                                  ),
                                ),
                                IconButton.outlined(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                      BorderSide(color: AppColors.white),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.notifications,

                                    color: AppColors.white,
                                    size: AppDimensions.size_24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: AppDimensions.spacing_4,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.white,
                                size: AppDimensions.size_28,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                  MediaQuery.sizeOf(context).width / 2 - 24,
                                  minWidth:
                                  MediaQuery.sizeOf(context).width / 2 - 24,
                                ),
                                child: Text(
                                  "User ddd edwdd d dw edw dwe dwedw we dw location",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.medium18P(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          AppLocal.provideBestFood.getString(context),
                          style: AppTextStyles.semiBold30P(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: HomeCategoryView(),
            ),

            HomeProductsView()
          ],
          //category



      ),
    );
  }
}
