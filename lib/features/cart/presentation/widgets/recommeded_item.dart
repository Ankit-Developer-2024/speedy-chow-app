import 'package:flutter/material.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class RecommededItem extends StatelessWidget {
  const RecommededItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.sizeOf(context).height/2-210,
      child: ListView.separated(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){

            },
            child: Container(
              width: 150,
              padding: EdgeInsets.all(AppDimensions.spacing_8),
              decoration: BoxDecoration(
                  color: AppColors.grey50.withAlpha(80),
                  borderRadius: BorderRadius.circular(AppDimensions.radius_8)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppDimensions.spacing_8,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(AppDimensions.radius_8),
                          child: Image.asset(getLocalJpeg("burger"),width: AppDimensions.size_126,)),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton.filledTonal(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppColors.white)
                          ),
                          icon: Icon(
                            Icons.favorite_outline_sharp,
                            color: AppColors.red1000,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("Burger Name sdfs df ccy s",style: AppTextStyles.medium18P(),overflow: TextOverflow.ellipsis,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimensions.spacing_8,
                    children: [
                      Icon(Icons.star,color: AppColors.darkOrange,size: AppDimensions.size_18,),
                      Text("Ratings",style: AppTextStyles.medium16P(),)
                    ],),
                  RichText(text: TextSpan(
                      style: AppTextStyles.medium16P(color: AppColors.darkOrange),
                      children: [
                        TextSpan(text: "₹"),
                        WidgetSpan(child: SizedBox(width: AppDimensions.spacing_8,)),
                        TextSpan(text: "Price"),
                      ]
                  ))
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(width: AppDimensions.spacing_14,);
        },
      ),
    );
  }
}
