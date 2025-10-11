import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';
import 'package:speedy_chow/features/home/presentation/widgets/category_bottom_sheet.dart';
import 'package:speedy_chow/features/home/presentation/widgets/loader_category_effect.dart';

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing_24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocal.findByCategory.getString(context),
                style: AppTextStyles.semiBold18P(),
              ),
              TextButton(
                  onPressed: () {
                    categoryBottomSheet(context,context.read<HomeBloc>());
                  },
                  child: Text(
                    AppLocal.seeAll.getString(context),
                    style: AppTextStyles.medium16P(color: AppColors.darkOrange),
                  ))
            ],
          ),
          SizedBox(
            height: AppDimensions.size_100,
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (prev,curr)=>curr is HomeSelectAndUnselectCategoryState || curr is HomeFetchAllCategoryState,
              builder: (context, state) {
                if(state is HomeSelectAndUnselectCategoryState){
                  return ListView.separated(
                    itemCount: context.read<HomeBloc>().selectedCategory.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<HomeBloc>().add(
                              HomeSelectAndUnselectCategoryEvent(
                                  isSelect: !context
                                      .read<HomeBloc>()
                                      .selectedCategory[index]
                                      .isSelected!,
                                  index: index));
                        },
                        borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                        child: Container(
                          padding: EdgeInsets.all(AppDimensions.spacing_4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                              border:BoxBorder.fromBorderSide(BorderSide(color: AppColors.darkOrange.withAlpha(100))),
                              color: context
                                  .read<HomeBloc>()
                                  .selectedCategory[index]
                                  .isSelected! ? AppColors.darkOrange.withAlpha(200) :AppColors.white
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry
                                    .circular(
                                    AppDimensions.radius_8),
                                child: CachedNetworkImage (
                                  imageUrl: context.read<HomeBloc>().selectedCategory[index].imgUrl,
                                  placeholder: (context, url) => Center(child: Icon(Icons.image_outlined,size: AppDimensions.size_72,color: AppColors.grey200)),
                                  errorWidget: (context, url, error) => Icon(Icons.error,size: AppDimensions.size_40,color: AppColors.red),
                                  fit: BoxFit.cover,
                                  width: AppDimensions.size_80,
                                  height: 70,
                                ),),
                              Text(
                                context
                                    .read<HomeBloc>()
                                    .selectedCategory[index]
                                    .name
                                    .toString(),
                                style: AppTextStyles.medium14P(
                                    color: context
                                        .read<HomeBloc>()
                                        .selectedCategory[index]
                                        .isSelected! ? AppColors.white : AppColors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: AppDimensions.spacing_20,
                      );
                    },
                  );
                }else{
                  return LoaderCategoryEffect();
                }

              },
            ),
          )
        ],
      ),
    );
  }
}
