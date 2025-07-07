import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CartBloc, CartState>(
     buildWhen: (prev,curr)=> curr is CartFetchUserCartState,
  builder: (context, state) {
    if(state is CartFetchUserCartState){
      if(state.loading==true){
        return Center(child: CircularProgressIndicator(),);
      }else if(state.data.cartItem==null){
        return Center(child: Text("No item in cart"),);
      }
      else{
        return ListView.separated(
          itemCount: 6,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return Container(
              padding: EdgeInsets.all(AppDimensions.spacing_4),
              decoration: BoxDecoration(
                  color: AppColors.grey50.withAlpha(80),
                  borderRadius: BorderRadius.circular(AppDimensions.radius_8)
              ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: AppDimensions.spacing_8,
                children: [
                  Row(
                    spacing: AppDimensions.spacing_10,
                    children: [
                      SizedBox(
                        width:MediaQuery.sizeOf(context).width/3,
                        height:MediaQuery.sizeOf(context).width/3,
                        child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(AppDimensions.radius_8),
                            child: Image.asset(getLocalJpeg("burger"),fit: BoxFit.fill,)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width:MediaQuery.sizeOf(context).width/3,
                              child: Text(state.data.cartItem![index].name.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: AppTextStyles.semibold18P(),)),
                          RichText(
                              text: TextSpan(
                                  style: AppTextStyles.medium18P(
                                      color: AppColors.darkOrange),
                                  children: [
                                    state.data.cartItem![index].discountPercentage == 0
                                        ? WidgetSpan(
                                        child: SizedBox(
                                          width: 0,
                                        ))
                                        : TextSpan(
                                        text:
                                        "${String.fromCharCode(8377)} ${state
                                            .data.cartItem![index].price.toString()}",
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
                                            state.data.cartItem![index].price!,
                                            state.data.cartItem![index]
                                                .discountPercentage!)}")
                                  ])),
                          state.data.cartItem![index].quantity!<=0 ? Text("Out of Stock",style: AppTextStyles.medium16P(color: AppColors.errorRed)) : Text("In Stock",style: AppTextStyles.medium16P(color: AppColors.primaryGreen)),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: (){}, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero,icon: Text('-',style: AppTextStyles.semiBold24P(),)),
                              Text("1",style: AppTextStyles.semibold18P()),
                              IconButton(onPressed: (){}, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero, icon: Text("+",style: AppTextStyles.semiBold24P())),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever_rounded,color: AppColors.errorRed,size: AppDimensions.size_32,))

                ],
              ),
            );
          },
          separatorBuilder: (context,index){
            return SizedBox(height: AppDimensions.spacing_14,);
          },
        );
      }
    }else{
      return Center(child: Text("No item in cart"),);
    }

  },
);
  }
}
