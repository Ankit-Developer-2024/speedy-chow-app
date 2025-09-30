import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/customLoader.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/cart/domain/entities/cart.dart';
import 'package:speedy_chow/features/cart/presentation/bloc/cart_bloc.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      itemCount: context.read<CartBloc>().items.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
        Cart item=context.read<CartBloc>().items[index];
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
                        child:
                        item.product?.img!=null ?  Image.memory(
                          item.product!.img!,
                          fit: BoxFit.cover,
                        ):
                        Image.asset(getLocalJpeg("burger"),fit: BoxFit.fill,)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width:MediaQuery.sizeOf(context).width/3,
                          child: Text(item.product!.name.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: AppTextStyles.semibold18P(),)),
                      RichText(
                          text: TextSpan(
                              style: AppTextStyles.medium18P(
                                  color: AppColors.darkOrange),
                              children: [
                                item.product!.discountPercentage == 0
                                    ? WidgetSpan(
                                    child: SizedBox(
                                      width: 0,
                                    ))
                                    : TextSpan(
                                    text:
                                    "${String.fromCharCode(8377)} ${item.product!.price.toString()}",
                                    style: TextStyle(
                                        decoration:
                                        TextDecoration.lineThrough,
                                        decorationThickness: 1.5,
                                        color: AppColors.grey300)),
                                item.product!.discountPercentage == 0
                                    ? WidgetSpan(
                                    child: SizedBox(
                                             width: 0))
                                    :WidgetSpan(
                                    child: SizedBox(
                                      width: AppDimensions.spacing_10,
                                    )),
                                TextSpan(
                                    text:
                                    "${String.fromCharCode(
                                        8377)} ${item.product!.discountedPrice}")
                              ])),
                      item.product!.quantity!<=0 ? Text("Out of stock",style: AppTextStyles.medium16P(color: AppColors.errorRed)) : Text("In stock",style: AppTextStyles.medium16P(color: AppColors.primaryGreen)),
                      BlocConsumer<CartBloc, CartState>(
                        listenWhen: (prev,curr)=>curr is UpdateCartState,
                        listener: (context,state){
                           if(state is UpdateCartState){
                             if(state.loading==true){
                               customLoader(context: context);
                             }
                             else {
                               context.pop();
                             }
                           }
                        },
                        buildWhen: (prev,curr)=>curr is UpdateCartState,
                        builder: (context, state) {
                          if(state is UpdateCartState){
                            if(state.success==true){
                              return Row(
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        item.quantity! <= 1
                                            ? null
                                            : context
                                            .read<CartBloc>()
                                            .add(UpdateCartEvent(
                                            cart: item,
                                            quantity:
                                            item.quantity! -
                                                1));
                                      }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero,icon: Text('-',style: AppTextStyles.semiBold24P(),)),
                                  Text(item.quantity.toString(),style: AppTextStyles.semibold18P()),
                                  IconButton(onPressed: (){
                                    item.product!.quantity! <= item.quantity!
                                        ? null
                                        : context
                                        .read<CartBloc>()
                                        .add(UpdateCartEvent(
                                        cart: item,
                                        quantity:
                                        item.quantity! +
                                            1));
                                  }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero, icon: Text("+",style: AppTextStyles.semiBold24P())),
                                ],
                              );
                            }else{
                              return Row(
                                children: [
                                  IconButton( onPressed: (){ }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero,icon: Text('-',style: AppTextStyles.semiBold24P(),)),
                                  Text(item.quantity.toString(),style: AppTextStyles.semibold18P()),
                                  IconButton(onPressed: (){}, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero, icon: Text("+",style: AppTextStyles.semiBold24P())),
                                ],
                              );
                            }
                          }else{
                            return Row(
                              children: [
                                IconButton(
                                    onPressed: (){
                                      item.quantity! <= 1
                                          ? null
                                          : context
                                          .read<CartBloc>()
                                          .add(UpdateCartEvent(
                                          cart: item,
                                          quantity:
                                          item.quantity! -
                                              1));
                                    }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero,icon: Text('-',style: AppTextStyles.semiBold24P(),)),
                                Text(item.quantity!.toString(),style: AppTextStyles.semibold18P()),
                                IconButton(onPressed: (){
                                  item.product!.quantity! <= item.quantity!
                                      ? null
                                      : context
                                      .read<CartBloc>()
                                      .add(UpdateCartEvent(
                                      cart: item,
                                      quantity:
                                      item.quantity! +
                                          1));
                                }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero, icon: Text("+",style: AppTextStyles.semiBold24P())),
                              ],
                            );
                          }

                        },
                       ),
                    ],
                  )
                ],
              ),
              BlocConsumer<CartBloc, CartState>(
                listenWhen: (prev,curr)=>curr is DeleteCartState,
                listener: (context,state){
                  if(state is DeleteCartState){
                    if(state.loading==true){
                      customLoader(context: context);
                    }
                    else {
                      context.pop();
                    }
                  }
                },
                buildWhen: (prev,curr)=>curr is DeleteCartState,
                builder: (context, state) {
                  return IconButton(onPressed: (){
                    context.read<CartBloc>().add(DeleteCartEvent(cart: item));
                  }, icon: Icon(Icons.delete_forever_rounded,color: AppColors.errorRed,size: AppDimensions.size_32,));

                },
                )

            ],
          ),
        );
      },
      separatorBuilder: (context,index){
        return SizedBox(height: AppDimensions.spacing_14,);
      },
    );
  }
}
