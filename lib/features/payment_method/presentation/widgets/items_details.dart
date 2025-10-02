import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/cart/domain/entities/cart.dart';
import 'package:speedy_chow/features/payment_method/presentation/bloc/payment_method_bloc.dart';

class ItemsDetails extends StatelessWidget {
  const ItemsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
      buildWhen: (prev,curr)=> curr is FetchCartState,
    builder: (context, state) {
        if(state is FetchCartState){
          if(state.loading==false && state.success==true && state.data.isNotEmpty){
            return ListView.separated(
              itemCount: state.data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                Cart item=state.data[index];
                return Container(
                  padding: EdgeInsets.all(AppDimensions.spacing_4),
                  decoration: BoxDecoration(
                      color: AppColors.grey50.withAlpha(80),
                      borderRadius: BorderRadius.circular(AppDimensions.radius_8)
                  ),
                  child:
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.spacing_10,
                    children: [
                      SizedBox(
                        width:MediaQuery.sizeOf(context).width/3,
                        height:MediaQuery.sizeOf(context).width/3,
                        child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(AppDimensions.radius_8),
                            child:
                             item.product?.img!=null ?
                             CachedNetworkImage(
                               imageUrl:item.product!.img!,
                               placeholder: (context, url) => CircularProgressIndicator(),
                               errorWidget: (context, url, error) => Icon(Icons.error),
                               fit: BoxFit.cover,
                             )
                             : Image.asset(getLocalJpeg("burger"),fit: BoxFit.cover,)
                        ),
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
                          // BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
                          //   listenWhen: (prev,curr)=>curr is UpdateCartState,
                          //   listener: (context,state){
                          //     if(state is UpdateCartState){
                          //       if(state.loading==true){
                          //         customLoader(context: context);
                          //       }
                          //       else {
                          //         context.pop();
                          //       }
                          //     }
                          //   },
                          //   buildWhen: (prev,curr)=>curr is UpdateCartState,
                          //   builder: (context, state) {
                          //     if(state is UpdateCartState){
                          //       if(state.success==true){
                          //         return Row(
                          //           children: [
                          //             IconButton(
                          //                 onPressed: (){
                          //                   item.quantity! <= 1
                          //                       ? null
                          //                       : context
                          //                       .read<CartBloc>()
                          //                       .add(UpdateCartEvent(
                          //                       cart: item,
                          //                       quantity:
                          //                       item.quantity! - 1));
                          //                 }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero,icon: Text('-',style: AppTextStyles.semiBold24P(),)),
                          //             Text(item.quantity.toString(),style: AppTextStyles.semibold18P()),
                          //             IconButton(onPressed: (){
                          //               item.product!.quantity! <= item.quantity!
                          //                   ? null
                          //                   : context
                          //                   .read<CartBloc>()
                          //                   .add(UpdateCartEvent(
                          //                   cart: item,
                          //                   quantity:
                          //                   item.quantity! +
                          //                       1));
                          //             }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero, icon: Text("+",style: AppTextStyles.semiBold24P())),
                          //           ],
                          //         );
                          //       }else{
                          //         return Row(
                          //           children: [
                          //             IconButton( onPressed: (){ }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero,icon: Text('-',style: AppTextStyles.semiBold24P(),)),
                          //             Text(item.quantity.toString(),style: AppTextStyles.semibold18P()),
                          //             IconButton(onPressed: (){}, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero, icon: Text("+",style: AppTextStyles.semiBold24P())),
                          //           ],
                          //         );
                          //       }
                          //     }else{
                          //       return Row(
                          //         children: [
                          //           IconButton(
                          //               onPressed: (){
                          //                 item.quantity! <= 1
                          //                     ? null
                          //                     : context
                          //                     .read<CartBloc>()
                          //                     .add(UpdateCartEvent(
                          //                     cart: item,
                          //                     quantity:
                          //                     item.quantity! -
                          //                         1));
                          //               }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero,icon: Text('-',style: AppTextStyles.semiBold24P(),)),
                          //           Text(item.quantity!.toString(),style: AppTextStyles.semibold18P()),
                          //           IconButton(onPressed: (){
                          //             item.product!.quantity! <= item.quantity!
                          //                 ? null
                          //                 : context
                          //                 .read<CartBloc>()
                          //                 .add(UpdateCartEvent(
                          //                 cart: item,
                          //                 quantity:
                          //                 item.quantity! +
                          //                     1));
                          //           }, visualDensity: VisualDensity(horizontal: 0,vertical: 0),padding: EdgeInsets.zero, icon: Text("+",style: AppTextStyles.semiBold24P())),
                          //         ],
                          //       );
                          //     }
                          //
                          //   },
                          // ),
                          //
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(height: AppDimensions.spacing_14,);
              },
            );
          }else{
            return Text(state.msg.toString(),style: AppTextStyles.medium14P(color: AppColors.errorRed),);
          }
        }else{
          return SizedBox.shrink();
        }
  },
);
  }
}
