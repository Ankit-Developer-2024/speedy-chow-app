import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

Future<dynamic> privacyPolicyBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.transparent,
    builder: (_) {
      return CustomAddressAuthBottomSheet();
    },
  );
}

class CustomAddressAuthBottomSheet extends StatelessWidget {
  const CustomAddressAuthBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.spacing_10,
            children: [
              IconButton.filledTonal(
                color: AppColors.black,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.white),
                ),
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.close_sharp),
              ),
              Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.all(AppDimensions.spacing_24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radius_16),
                      topRight: Radius.circular(AppDimensions.radius_16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppDimensions.spacing_6,
                    children: [
                      Text("Speedy Chow Privacy Policy",style: AppTextStyles.semiBold24P(),),
                      RichText(
                          text: TextSpan(

                        children: [
                         TextSpan(
                           text: "Last Updated: ",
                           style: AppTextStyles.semiBold16P()
                         ),
                          TextSpan(
                              text: "October 9, 2025",
                            style: AppTextStyles.regular16P()
                          ),
                        ]
                      )),
                      Text("Speedy Chow operates the Speedy Chow mobile application, a fast-food ordering platform that allows users to browse menus, place online orders, make payments, and get their favorite meals delivered to their chosen location.",style: AppTextStyles.medium16P(),),
                      Text("We value your trust and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and protect your data when you use our App.",style: AppTextStyles.medium16P(),),
                      Text("1. Information We Collect",style: AppTextStyles.semiBold18P(),),
                      Text("We collect the following types of information to provide and improve our services:",style: AppTextStyles.medium16P(),),
                      Text("a. Personal Information",style: AppTextStyles.medium16P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Full name",style: AppTextStyles.medium16P(),),
                            Text("- Email address",style: AppTextStyles.medium16P(),),
                            Text("- Phone number",style: AppTextStyles.medium16P(),),
                            Text("- Date of birth (optional)",style: AppTextStyles.medium16P(),),
                            Text("- Gender (optional)",style: AppTextStyles.medium16P(),),
                            Text("- Profile picture (optional)",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      Text("b. Location Information",style: AppTextStyles.medium16P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Deliver your order to the correct address",style: AppTextStyles.medium16P(),),
                            Text("- Deliver your order to the correct address",style: AppTextStyles.medium16P(),),
                            Text("You can enable or disable location access through your device settings at any time.",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      Text("c. Payment Information",style: AppTextStyles.medium16P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Online payment (UPI, credit/debit cards, net banking, wallets via Razorpay)",style: AppTextStyles.medium16P(),),
                            Text("- Cash on Delivery (COD)",style: AppTextStyles.medium16P(),),
                            Text("We collect payment details securely through trusted third-party payment gateways. We do not store your full card details or payment credentials on our servers.",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      Text("d. Device Information",style: AppTextStyles.medium16P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Device model, OS version, unique device ID",style: AppTextStyles.medium16P(),),
                            Text("- IP address",style: AppTextStyles.medium16P(),),
                            Text("- App usage statistics and crash logs",style: AppTextStyles.medium16P(),),
                            Text("This helps us improve app performance and user experience.",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      //2
                      Text("2. How We Use Your Information",style: AppTextStyles.semiBold18P(),),
                      Text("We use your data to:",style: AppTextStyles.medium16P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Create and manage your user account",style: AppTextStyles.medium16P(),),
                            Text("- Process and deliver your orders",style: AppTextStyles.medium16P(),),
                            Text("- Communicate about your order status and offers",style: AppTextStyles.medium16P(),),
                            Text("- Personalize your in-app experience",style: AppTextStyles.medium16P(),),
                            Text("- Improve app functionality and performance",style: AppTextStyles.medium16P(),),
                            Text("- Provide customer support",style: AppTextStyles.medium16P(),),
                            Text("- Comply with legal obligations",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      //3
                      Text("3. Your Data Rights",style: AppTextStyles.semiBold18P(),),
                      Text("You have the right to:",style: AppTextStyles.medium16P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Access and update your personal information",style: AppTextStyles.medium16P(),),
                            Text("- Delete your account (which will remove your data after 7 days)",style: AppTextStyles.medium16P(),),
                            Text("- Withdraw consent for location access or notifications",style: AppTextStyles.medium16P(),),
                           ],
                        ),
                      ),
                      Text("4. Changes to This Policy",style: AppTextStyles.semiBold18P(),),
                      Text("We may update this Privacy Policy periodically. Any changes will be posted here with an updated “Last Updated” date. Continued use of the App means you agree to the revised policy.",style: AppTextStyles.medium16P(),),
                      Text("5. Contact Us",style: AppTextStyles.semiBold18P(),),
                      Text("If you have any questions or concerns about this Privacy Policy, please contact us at:",style: AppTextStyles.medium16P(),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppDimensions.spacing_8,
                        children: [
                          Icon(Icons.email_outlined,size: AppDimensions.size_20,),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width-76,
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Email: ",
                                          style: AppTextStyles.semiBold16P()
                                      ),
                                      TextSpan(
                                          text: "support@speedychow.com",
                                          style: AppTextStyles.regular16P()
                                      ),
                                    ]
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppDimensions.spacing_8,
                        children: [
                          Icon(Icons.location_on_outlined,size: AppDimensions.size_20,),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width-76,
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Address: ",
                                          style: AppTextStyles.semiBold16P()
                                      ),
                                      TextSpan(
                                          text: "Speedy Chow Pvt. Ltd., Gurugram, Haryana, India",
                                          style: AppTextStyles.regular16P()
                                      ),
                                    ]
                                )),
                          ),
                        ],
                      ),
                    ],
                  )
              )
            ]
        ),
      ),
    );
  }
}

