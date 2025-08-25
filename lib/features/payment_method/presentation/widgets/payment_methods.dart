import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocal.selectPaymentMethod.getString(context),
          style: AppTextStyles.semibold18P(),
        ),
        CheckboxMenuButton(
          value: true,
          onChanged: (val) {},
          child: Text(
            AppLocal.cashOnDelivery.getString(context),
            style: AppTextStyles.medium14P(),
          ),
        ),
        CheckboxMenuButton(
          value: true,
          onChanged: (val) {},
          child: Text("UPI", style: AppTextStyles.medium14P()),
        ),
      ],
    );
  }
}
