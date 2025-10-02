import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/cart/domain/entities/cart.dart';

class OrderDetailItem extends StatelessWidget {
  const OrderDetailItem({super.key,required this.items});
  final List<Cart> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context,index){
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
                borderRadius:
                BorderRadiusGeometry.circular(AppDimensions.radius_8),
                child:items[index].product?.img != null ?
        CachedNetworkImage(
        imageUrl: items[index].product!.img!,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        width: MediaQuery .sizeOf(context) .width / 2 - 45,
        )
                    : Image.asset(
                  getLocalJpeg("burger"),
                  width: MediaQuery.sizeOf(context).width / 2,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${items[index].quantity.toString()} items",style: AppTextStyles.medium16P(),),
                Text("\u{20B9} ${(items[index].quantity! * items[index].product!.discountedPrice!)}",style: AppTextStyles.medium16P(),),
              ],
            )
          ],
        );
      },
      separatorBuilder: (context,index){
        return SizedBox(height: AppDimensions.spacing_8,);
      },);
  }
}
