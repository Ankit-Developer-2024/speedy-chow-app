import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:speedy_chow/core/components/widgets/get_address.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/order/domain/entities/order.dart';
import 'package:speedy_chow/features/order/presentation/bloc/order_bloc.dart';

class OrderDetailInfo extends StatelessWidget {
  const OrderDetailInfo({super.key,required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppDimensions.spacing_4,
      children: [
        Row(
          children: [
            Text(
              AppLocal.orderedStatus.getString(context),
              style: AppTextStyles.semiBold20P(),
            ),
            Text(
              context.read<OrderBloc>().getOrderStatus(order.status),
              style: AppTextStyles.semiBold20P(
                  color:context.read<OrderBloc>().getOrderStatusColor(order.status)
              ),
            ),
          ],
        ),
        order.status == OrderStatus.cancelled
            ? Text(
          order.statusReason.toString(),
          style: AppTextStyles.medium16P(),
          maxLines: 4 ,
        )
            : SizedBox.shrink(),
        Text("${AppLocal.totalAmount.getString(context)} ${order.totalAmount.toString()}",style: AppTextStyles.semiBold20P(),),
        Text(
          AppLocal.shippingAddress.getString(context),
          style: AppTextStyles.semiBold20P(),
        ),
        GetAddress(address:order.address, textStyle: null),
      ],
    );
  }
}
