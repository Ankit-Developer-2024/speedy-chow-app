import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

Future<dynamic> termsAndConditionsBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.transparent,
    builder: (_) {
      return CustomTermsAndConditionsBottomSheet();
    },
  );
}

class CustomTermsAndConditionsBottomSheet extends StatelessWidget {
  const CustomTermsAndConditionsBottomSheet({super.key});

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
                      Text("Speedy Chow Terms And Conditions 👇",style: AppTextStyles.semiBold24P(),),
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
                      Text("Welcome to Speedy Chow, operated by Speedy Chow Pvt. Ltd. (“we”, “our”, “us”).These Terms and Conditions ('Terms') govern your access and use of the Speedy Chow mobile application and related services.",style: AppTextStyles.medium16P(),),
                      Text("By downloading, installing, or using our App, you agree to these Terms. If you do not agree, please do not use the App.",style: AppTextStyles.medium16P(),),
                      Text("1. Account Registration",style: AppTextStyles.semiBold18P(),),
                      Text("To use certain features (e.g., placing an order), you must create an account by providing:",style: AppTextStyles.medium16P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Your name, email, and phone number",style: AppTextStyles.medium16P(),),
                            Text("- A password",style: AppTextStyles.medium16P(),),
                            Text("- Optional details like profile picture, date of birth, and gender",style: AppTextStyles.medium16P(),),
                            Text("You agree to provide accurate, current, and complete information. We reserve the right to suspend or terminate your account if false or misleading information is provided.",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      //2
                      Text("2. Orders and Payments",style: AppTextStyles.semiBold18P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Once an order is placed, it cannot be modified. Cancellation may be allowed only before the restaurant starts preparing the food.",style: AppTextStyles.medium16P(),),
                            Text("- Online payment: via Razorpay (UPI, cards, net banking, wallets, etc.)",style: AppTextStyles.medium16P(),),
                            Text("- Cash on Delivery (COD): available for select orders and areas",style: AppTextStyles.medium16P(),),
                            Text("- All payments are processed securely through trusted third-party gateways. We do not store your payment card details.",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      Text("3. Refunds and Cancellations",style: AppTextStyles.semiBold18P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- If an order is cancelled before preparation, you will be eligible for a full refund.",style: AppTextStyles.medium16P(),),
                            Text("- Once preparation begins, no refund will be issued.",style: AppTextStyles.medium16P(),),
                            Text("- In case of payment failure, any amount deducted will be automatically refunded by the payment gateway within 5–7 business days.",style: AppTextStyles.medium16P(),),
                            Text("- For complaints or refund requests, contact: support@speedychow.com",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      Text("4. Account Termination",style: AppTextStyles.semiBold18P(),),
                      Text("You may delete your account anytime under Profile → Delete Account.",style: AppTextStyles.medium16P(),),
                      Text("We may suspend or terminate your account if:",style: AppTextStyles.medium16P(),),
                      Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- You violate these Terms",style: AppTextStyles.medium16P(),),
                            Text("- Engage in fraud or abuse",style: AppTextStyles.medium16P(),),
                            Text("- Provide false information",style: AppTextStyles.medium16P(),),
                            Text("Upon deletion, your data will be permanently removed within 7 days",style: AppTextStyles.medium16P(),),
                          ],
                        ),
                      ),
                      Text("3. Changes to This Policy",style: AppTextStyles.semiBold18P(),),
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

