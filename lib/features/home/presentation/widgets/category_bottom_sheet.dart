import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';

Future<dynamic> categoryBottomSheet(BuildContext context, HomeBloc bloc) {
  return showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppDimensions.spacing_8,
              children: [
                IconButton.filledTonal(
                  color: AppColors.black,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.white),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.close_sharp),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(AppDimensions.spacing_24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radius_16),
                      topRight: Radius.circular(AppDimensions.radius_16),
                    ),
                  ),
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (prev, curr) =>
                        curr is HomeSelectAndUnselectCategoryState,
                    builder: (context, state) {
                      if (state is HomeSelectAndUnselectCategoryState) {
                        return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          runSpacing: AppDimensions.spacing_8,
                          spacing: AppDimensions.spacing_8,
                          children: [
                            ...context
                                .read<HomeBloc>()
                                .selectedCategory
                                .indexed
                                .map((category) {
                              var (index, item) = category;
                              return SizedBox(
                                  height: AppDimensions.size_100,
                                  child: InkWell(
                                    onTap: () {
                                      context.read<HomeBloc>().add(
                                          HomeSelectAndUnselectCategoryEvent(
                                              isSelect: !context
                                                  .read<HomeBloc>()
                                                  .selectedCategory[index]
                                                  .isSelected!,
                                              index: index));
                                    },
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.radius_8),
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          AppDimensions.spacing_4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.radius_8),
                                          border: BoxBorder.fromBorderSide(
                                                  BorderSide(
                                                      color: AppColors
                                                          .darkOrange
                                                          .withAlpha(100))),
                                          color: item.isSelected!
                                              ? AppColors.darkOrange.withAlpha(200)
                                              : AppColors.white),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadiusGeometry
                                                .circular(
                                                AppDimensions.radius_8),
                                            child: CachedNetworkImage (
                                              imageUrl: context
                                                  .read<HomeBloc>()
                                                  .selectedCategory[index]
                                                  .imgUrl,
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                              fit: BoxFit.cover,
                                              width: AppDimensions.size_68,
                                              height: 70,
                                            ),),
                                          Text(
                                            item.name.toString(),
                                            style: AppTextStyles.medium14P(
                                                color: item.isSelected!
                                                    ? AppColors.white
                                                    : AppColors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            })
                          ],
                        );
                      }
                      else {
                        return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          runSpacing: AppDimensions.spacing_8,
                          spacing: AppDimensions.spacing_8,
                          children: [
                            ...context
                                .read<HomeBloc>()
                                .selectedCategory
                                .indexed
                                .map((category) {
                              var (index, item) = category;
                              return SizedBox(
                                  height: AppDimensions.size_100,
                                  child: InkWell(
                                    onTap: () {
                                      context.read<HomeBloc>().add(
                                          HomeSelectAndUnselectCategoryEvent(
                                              isSelect: !context
                                                  .read<HomeBloc>()
                                                  .selectedCategory[index]
                                                  .isSelected!,
                                              index: index));
                                    },
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.radius_8),
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          AppDimensions.spacing_4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.radius_8),
                                          border: BoxBorder.fromBorderSide(
                                              BorderSide(
                                                  color: AppColors
                                                      .darkOrange
                                                      .withAlpha(100))),
                                          color: item.isSelected!
                                              ? AppColors.darkOrange.withAlpha(200)
                                              : AppColors.white),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadiusGeometry
                                                .circular(
                                                AppDimensions.radius_8),
                                            child: CachedNetworkImage (
                                              imageUrl: context
                                                  .read<HomeBloc>()
                                                  .selectedCategory[index]
                                                  .imgUrl,
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                              fit: BoxFit.cover,
                                              width: AppDimensions.size_80,
                                              height: 70,
                                            ),),

                                          Text(
                                            item.name.toString(),
                                            style: AppTextStyles.medium14P(
                                                color: item.isSelected!
                                                    ? AppColors.white
                                                    : AppColors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            })
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
