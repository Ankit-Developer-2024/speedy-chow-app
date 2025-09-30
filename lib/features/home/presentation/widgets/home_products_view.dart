import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/custom_snackbar.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';
import 'package:speedy_chow/features/home/presentation/widgets/loader_home_product_view_effect.dart';

class HomeProductsView extends StatelessWidget {
  const HomeProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: AppDimensions.spacing_24,
        right: AppDimensions.spacing_24,
        left: AppDimensions.spacing_24,
      ),
      sliver: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (prev, curr) =>
        curr is HomeFetchAllProductState ,
        listener: (context, state) {
          if(state is HomeFetchAllProductState){
            if(state.loading==false && state.success==false){
              customSnackBar(context, state.msg);
            }
          }
        },
        buildWhen: (prev, curr) =>
            curr is HomeFetchAllProductState ,
        builder: (context, state) {
          if (state is HomeFetchAllProductState) {
               if(state.loading==true){
                 return LoaderHomeProductViewEffect();
               }
               if(state.data.isEmpty){
                  return SliverToBoxAdapter(
                    child:Column(
                      spacing: AppDimensions.spacing_10,
                      children: [
                        Icon(Icons.search_outlined,size: AppDimensions.size_96,color: AppColors.darkOrange,),
                        Text(AppLocal.noProductFound.getString(context),style: AppTextStyles.semiBold24P(color: AppColors.darkOrange),),
                        Button(onTap: (){
                          context.read<HomeBloc>().add(HomeFetchAllProductEvent());
                        }, child: Center(child: Text(AppLocal.refresh.getString(context),style: AppTextStyles.semiBold16P(color: AppColors.white),),))
                      ],
                    )
                  );
               }else {
                 return SliverGrid(
                   delegate: SliverChildBuilderDelegate(
                       childCount: state.data.length, (context, index) {
                     return InkWell(
                       onTap: () {
                         context.pushNamed(AppRoutes.productDetails,
                             extra: state.data[index]);
                       },
                       child: Container(
                         padding: EdgeInsets.all(AppDimensions.spacing_8),
                         decoration: BoxDecoration(
                             color: AppColors.grey50.withAlpha(80),
                             borderRadius:
                             BorderRadius.circular(AppDimensions.radius_8)),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           spacing: AppDimensions.spacing_8,
                           children: [
                             state.data[index].img!=null ?  ClipRRect(
                                 borderRadius: BorderRadiusGeometry
                                     .circular(
                                     AppDimensions.radius_8),
                                 child: Image.memory(
                                    state.data[index].img!,
                                   fit: BoxFit.cover,
                                   width:
                                   MediaQuery
                                       .sizeOf(context)
                                       .width / 2 - 45,
                                   height:
                                   MediaQuery
                                       .sizeOf(context)
                                       .width / 2 - 94,
                                 )) : ClipRRect(
                                 borderRadius: BorderRadiusGeometry
                                     .circular(
                                     AppDimensions.radius_8),
                                 child: Image.asset(
                                   getLocalJpeg("burger"),
                                   width:
                                   MediaQuery
                                       .sizeOf(context)
                                       .width / 2 - 45,
                                   height:  MediaQuery
                                       .sizeOf(context)
                                       .width / 2 - 94,
                                 )) ,
                             Text(
                               state.data[index].name ?? '',
                               style: AppTextStyles.medium18P(),
                               overflow: TextOverflow.ellipsis,
                             ),
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisSize: MainAxisSize.min,
                               spacing: AppDimensions.spacing_8,
                               children: [
                                 Icon(
                                   Icons.star,
                                   color: AppColors.darkOrange,
                                 ),
                                 Text(state.data[index].rating.toString(),
                                     style: AppTextStyles.medium18P())
                               ],
                             ),
                             RichText(
                                 text: TextSpan(
                                     style: AppTextStyles.medium20P(
                                         color: AppColors.darkOrange),
                                     children: [
                                       state.data[index].discountPercentage == 0
                                           ? WidgetSpan(
                                           child: SizedBox(
                                             width: 0,
                                           ))
                                           : TextSpan(
                                           text:
                                           "${String.fromCharCode(8377)} ${state
                                               .data[index].price.toString()}",
                                           style: TextStyle(
                                               decoration:
                                               TextDecoration.lineThrough,
                                               decorationThickness: 1.5,
                                               color: AppColors.grey300)),
                                       WidgetSpan(
                                           child: SizedBox(
                                             width: AppDimensions.spacing_10,
                                           )),
                                       TextSpan(
                                           text:
                                           "${String.fromCharCode(
                                               8377)} ${discountPrice(
                                               state.data[index].price!,
                                               state.data[index]
                                                   .discountPercentage!)}")
                                     ])),
                           ],
                         ),
                       ),
                     );
                   }),
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       crossAxisSpacing: AppDimensions.spacing_10,
                       mainAxisSpacing: AppDimensions.spacing_10,
                       mainAxisExtent: 225),
                 );
               }

          }  else {
            return SliverToBoxAdapter(
                child:Column(
                  spacing: AppDimensions.spacing_10,
                  children: [
                    Icon(Icons.search_outlined,size: AppDimensions.size_96,color: AppColors.darkOrange,),
                    Text(AppLocal.noProductFound.getString(context),style: AppTextStyles.semiBold24P(color: AppColors.darkOrange),),
                    Button(onTap: (){
                      context.read<HomeBloc>().add(HomeFetchAllProductEvent());
                    }, child: Center(child: Text(AppLocal.refresh.getString(context),style: AppTextStyles.semiBold16P(color: AppColors.white),),))
                  ],
                )
            );
          }
        },
      ),
    );
  }
}
