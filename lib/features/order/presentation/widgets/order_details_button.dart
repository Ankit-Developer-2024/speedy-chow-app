import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/components/models/address_model.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/order/data/models/order_model.dart';
import 'package:speedy_chow/features/order/domain/entities/order.dart';
import 'package:speedy_chow/features/order/presentation/bloc/order_bloc.dart';
import 'package:speedy_chow/features/order/presentation/widgets/buy_again_bottom_sheet.dart';

class OrderDetailsButton extends StatelessWidget {
  const OrderDetailsButton({super.key,required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Button(
              onTap: () {
                context.read<OrderBloc>().selectedAddress= order.address! as AddressModel;
                buyAgainBottomSheet(context,data:(order as OrderModel).toJson(),previousAddress:order.address! as AddressModel );
              },
              width: 110,
              color: AppColors.primaryGreen,
              child: Center(
                  child: Text(
                    AppLocal.buyAgain.getString(context),
                    style: AppTextStyles.semiBold14P(
                        color: AppColors.white),
                  ))),
          SizedBox(
            width: AppDimensions.spacing_10,
          ),
          order.status != OrderStatus.cancelled ?  Button(
              onTap: () {
                context.read<OrderBloc>().add(UpdateOrderEvent(id: order.id!,  data: {
                  'statusReason':"Order cancelled by you.",
                  'status':"Cancelled"
                }));
              },
              width: 110,
              color: AppColors.errorRed,
              child: Center(
                  child: Text(
                    AppLocal.cancelOrder.getString(context),
                    style: AppTextStyles.semiBold14P(
                        color: AppColors.white),
                  ))) : SizedBox.shrink(),
        ],
      ),
    );
  }
}
