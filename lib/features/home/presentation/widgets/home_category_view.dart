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
            height: AppDimensions.size_89,
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
                          padding: EdgeInsets.all(AppDimensions.spacing_8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                              border:BoxBorder.fromBorderSide(BorderSide(color: AppColors.darkOrange.withAlpha(100))),
                              color: context
                                  .read<HomeBloc>()
                                  .selectedCategory[index]
                                  .isSelected! ? AppColors.darkOrange :AppColors.white
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                getLocalSvg("success"),
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: AppDimensions.spacing_8,
                              ),
                              Text(
                                context
                                    .read<HomeBloc>()
                                    .selectedCategory[index]
                                    .name
                                    .toString(),
                                style: AppTextStyles.medium16P(
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
