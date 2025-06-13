import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.sizeOf(context).height/2,
      child: ListView.separated(
        itemCount: 10,
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
                      width:MediaQuery.sizeOf(context).width/4,
                      height:MediaQuery.sizeOf(context).width/4,
                      child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(AppDimensions.radius_8),
                          child: Image.asset(getLocalJpeg("burger"),fit: BoxFit.fill,)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width:100,
                            child: Text("Burget anme ds d d ds fs fsd fsd fsd sd  sd fs da dasdsad asd asd asd ad as",maxLines: 1,overflow: TextOverflow.ellipsis,style: AppTextStyles.semibold18P(),)),
                        Text("\$ Price",style: AppTextStyles.medium18P(color: AppColors.darkOrange)),
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
                IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever_rounded,color: AppColors.errorRed,))




              ],
            ),
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(height: AppDimensions.spacing_14,);
        },
      ),
    );
  }
}
