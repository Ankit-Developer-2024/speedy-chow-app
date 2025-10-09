import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/profile/presentation/widgets/profile_item_app_bar.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileItemAppBar(title: AppLocal.helpCenter.getString(context)) as PreferredSizeWidget,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: AppDimensions.size_24,right:AppDimensions.size_24,top: AppDimensions.spacing_8,bottom: AppDimensions.spacing_8  ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimensions.spacing_6,
            children: [
               Text("🍔 Help Center 👇",style: AppTextStyles.semiBold24P(),),
               Text("Welcome to the Help Center of Speedy Chow — we’re here to make your experience smooth and delicious!",style: AppTextStyles.medium16P(),),
               Text("If you have any questions, feedback, or need support, you’re in the right place.",style: AppTextStyles.medium16P(),),
               SizedBox(height: AppDimensions.spacing_3,),
               Text("🧾 1. Order Related Queries",style: AppTextStyles.semiBold18P(),),
               Text("1.1 How can I place an order?",style: AppTextStyles.medium16P(),),
               Padding(
                padding: const EdgeInsets.only(left: AppDimensions.spacing_6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("- Browse through the menu.",style: AppTextStyles.medium16P(),),
                    Text("- Add your favorite items to the cart.",style: AppTextStyles.medium16P(),),
                    Text("- Choose your payment method — Online Payment or Cash on Delivery (COD).",style: AppTextStyles.medium16P(),),
                    Text("- Confirm your address and place the order.",style: AppTextStyles.medium16P(),),
                  ],
                ),
              ),
               Text("1.2 How can I cancel or modify an order?",style: AppTextStyles.medium16P(),),
               Text("Once your order is start preparing, modifications or cancellations may not be possible if it’s already being prepared.",style: AppTextStyles.medium16P(),),
               Text("For urgent changes, please contact our customer support team immediately.",style: AppTextStyles.medium16P(),),
               Text("1.3 What if I received the wrong or incomplete order?",style: AppTextStyles.medium16P(),),
               Text("We’re sorry! Please reach out to us via the “Contact Us” section or email [support@speedychow.com] with your order details, and we’ll resolve it as soon as possible.",style: AppTextStyles.medium16P(),),
               //2
              Text("💳 2. Payment and Refunds",style: AppTextStyles.semiBold18P(),),
              Text("2.1 What payment methods are accepted?",style: AppTextStyles.medium16P(),),
              Text("We accept UPI, Credit/Debit Cards, Net Banking, and Cash on Delivery (COD).",style: AppTextStyles.medium16P(),),
              Text("2.2 When will I get my refund?",style: AppTextStyles.medium16P(),),
              Text("Refunds (for failed or canceled orders) are processed within 5–7 business days, depending on your bank or payment provider.",style: AppTextStyles.medium16P(),),
              //3
              Text("👤 3. Profile & Account",style: AppTextStyles.semiBold18P(),),
              Text("3.1 How do I update my profile picture or details?",style: AppTextStyles.medium16P(),),
              Text("Go to Profile → Personal Data, update your photo or information, and save changes.",style: AppTextStyles.medium16P(),),
              Text("3.2 How do I delete my account?",style: AppTextStyles.medium16P(),),
              Text("You can request account deletion by contacting our support team at [support@speedychow.com].",style: AppTextStyles.medium16P(),),
              //4
              Text("🛠️ 4. Technical Issues",style: AppTextStyles.semiBold18P(),),
              Text("4.1 App not working properly?",style: AppTextStyles.medium16P(),),
              Text("Try closing and reopening the app or checking your internet connection.",style: AppTextStyles.medium16P(),),
              Text("If the issue persists, reinstall the app or contact our support team.",style: AppTextStyles.medium16P(),),
              Text("4.2 Payment failed but amount deducted?",style: AppTextStyles.medium16P(),),
              Text("Don’t worry! Your money is safe. It will be automatically refunded within 5–7 business days.",style: AppTextStyles.medium16P(),),
              //5
              Text("📞 5. Contact Support",style: AppTextStyles.semiBold18P(),),
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
                  Icon(Icons.phone,size: AppDimensions.size_20,),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width-76,
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Phone: ",
                                  style: AppTextStyles.semiBold16P()
                              ),
                              TextSpan(
                                  text: "80596-*****",
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
                  Icon(Icons.watch_later_outlined,size: AppDimensions.size_20,),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width-76,
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Support Hours: ",
                                  style: AppTextStyles.semiBold16P()
                              ),
                              TextSpan(
                                  text: "9:00 AM – 11:00 PM (Mon–Sun)",
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
          ),
        ),
      ),
    );
  }
}
