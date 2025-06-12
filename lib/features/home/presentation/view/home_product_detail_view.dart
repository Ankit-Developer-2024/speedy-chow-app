import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';

class HomeProductDetailView extends StatelessWidget {
  const HomeProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
           fit: StackFit.loose,
          children: [
              Container(
                padding: EdgeInsets.only(top: AppDimensions.spacing_20),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height/2-70,
              child: Image.asset(getLocalJpeg("burger"),fit: BoxFit.fill,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppDimensions.spacing_34),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.outlined(onPressed: (){
                    context.pop();
                  }, icon: Icon(Icons.arrow_back_ios_outlined)),
                  IconButton.outlined(onPressed: (){
                    context.pop();
                  }, icon: Icon(Icons.favorite_outline_sharp))
                ],
              ),
            ),
            Align(
              alignment: Alignment(0,1),
              child: Container(

                height: MediaQuery.sizeOf(context).height/2+100,
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.only(left: AppDimensions.spacing_24,right: AppDimensions.spacing_24,top: AppDimensions.spacing_16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                    borderRadius: BorderRadius.only(topRight:Radius.circular( AppDimensions.radius_50),topLeft: Radius.circular( AppDimensions.radius_50))

                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppDimensions.spacing_8,
                    children: [
                      Text("Burget anme ds d d ds fs fsd fsd fsd sd  sd fs da dasdsad asd asd asd ad as",maxLines: 2,overflow: TextOverflow.ellipsis,style: AppTextStyles.semiBold27P(),),
                      Text("\$ Price",style: AppTextStyles.medium20P(color: AppColors.darkOrange)),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal:  8.0),
                        decoration: BoxDecoration(
                          color: AppColors.darkOrange.withAlpha(40),
                          borderRadius: BorderRadius.circular(AppDimensions.radius_12)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: AppDimensions.spacing_4,
                              children: [
                                Text("\$",style: AppTextStyles.medium14P(color: AppColors.darkOrange)),
                                Text("Free delivery",style: AppTextStyles.medium14P(color: AppColors.grey500)),
                              ],
                            ),
                            Row(
                              spacing: AppDimensions.spacing_4,
                              children: [
                                Icon(Icons.watch_later_outlined,color: AppColors.darkOrange),
                                Text("20-30",style: AppTextStyles.medium14P(color: AppColors.grey500)),
                              ],
                            ),
                            Row(
                              spacing: AppDimensions.spacing_4,
                              children: [
                                Icon(Icons.star,color: AppColors.darkOrange,),
                                Text("4.5",style: AppTextStyles.medium14P(color: AppColors.grey500),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text("Description",style: AppTextStyles.semiBold24P()),
                      Text(
                        """
                  freestar
                  Հայերեն Shqip ‫العربية Български Català 中文简体 Hrvatski Česky Dansk Nederlands English Eesti Filipino Suomi Français ქართული Deutsch Ελληνικά ‫עברית हिन्दी Magyar Indonesia Italiano Latviski Lietuviškai македонски Melayu Norsk Polski Português Româna Pyccкий Српски Slovenčina Slovenščina Español Svenska ไทย Türkçe Українська Tiếng Việt
                  Lorem Ipsum
                  "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."
                  "T    """
                      )
                  
                    ],
                  ),
                ),
              ),
            ),

            //add to cart btn

            Align(
              alignment: Alignment(-1, 1),
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing_24,vertical: AppDimensions.spacing_2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Row(
                         children: [
                           IconButton(onPressed: (){}, icon: Text('-',style: AppTextStyles.semiBold24P(),)),
                           Text("1",style: AppTextStyles.semibold18P()),
                           IconButton(onPressed: (){}, icon: Text("+",style: AppTextStyles.semiBold24P())),
                         ],
                       ),
                      Text("\$ Price",style: AppTextStyles.semiBold24P(color: AppColors.darkOrange) ,),
                    ],),
                    Button(onTap: (){}, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart,color: AppColors.white,),
                        Text("Add to Cart",style: AppTextStyles.semiBold14P(color: AppColors.white),)
                      ],))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
