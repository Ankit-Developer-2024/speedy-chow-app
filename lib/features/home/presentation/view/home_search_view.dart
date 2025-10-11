import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/home/presentation/bloc/home_bloc.dart';

class HomeSearchView extends StatelessWidget {
  const HomeSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                leadingWidth: 20,
                iconTheme: IconThemeData(size: 20),
                title: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search product by name..."
                  ),
                  onChanged: (val) {
                    context.read<HomeBloc>().add(
                        HomeSearchProductByNameEvent(name: val));
                  },
                ),
                pinned: true,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (prev,curr)=> curr is HomeSearchProductByNameState,
                builder: (context, state) {
                  if(state is HomeSearchProductByNameState){
                     if(state.loading==true){
                       return SliverToBoxAdapter(child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Center(child: CircularProgressIndicator(),),
                       ));
                     }else if(state.success==true && state.searchProduct.isNotEmpty){
                       return SliverList.separated(
                           itemCount: state.searchProduct.length,
                           itemBuilder: (context, index) {
                             return Padding(
                               padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing_8),
                               child: ListTile(
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radius_8))),
                                 contentPadding: EdgeInsets.all(AppDimensions.spacing_8),
                                 style: ListTileStyle.drawer,
                                 tileColor: AppColors.grey100.withAlpha(80),
                                 onTap: (){
                                   context.pushNamed(AppRoutes.productDetails,
                                       extra: state.searchProduct[index].id);
                                 },
                                 leading: SizedBox(
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(AppDimensions.radius_8),
                                     child: CachedNetworkImage(
                                         imageUrl: state.searchProduct[index].image,
                                       placeholder: (context, url) => Center(child: Icon(Icons.image_outlined)),
                                       errorWidget: (context, url, error) => Icon(Icons.error),
                                       width: AppDimensions.size_80,
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                                 title: Text(state.searchProduct[index].name ,style: AppTextStyles.medium16P(),),
                                 trailing: Text("\u{20B9} ${state.searchProduct[index].discountedPrice}".toString(),style:AppTextStyles.semiBold18P(),),
                               ),
                             );
                           },
                         separatorBuilder: (context,index){
                             return SizedBox(height: AppDimensions.spacing_8,);
                         },
                           );
                     }else{
                       return SliverToBoxAdapter(child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Center(child: Text(state.msg,style: AppTextStyles.medium16P(),),),
                       ),);
                     }
                  }else{
                    return SliverToBoxAdapter(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("No product searched.",style: AppTextStyles.medium16P(),)),
                    ));
                  }

                },
              )
            ],
          )),
    );
  }
}
