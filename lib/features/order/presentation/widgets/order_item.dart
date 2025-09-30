import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/routing/app_routes.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/order/domain/entities/order.dart';
import 'package:speedy_chow/features/order/presentation/bloc/order_bloc.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.orderDetails,
            extra: context.read<OrderBloc>(),
            pathParameters: {'id': order.id.toString()});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: AppDimensions.spacing_6,
              children: [
                ClipRRect(
                    borderRadius:
                        BorderRadiusGeometry.circular(AppDimensions.radius_8),
                    child:order.items?[0].product?.img != null ?
                       ClipRRect(
                        borderRadius: BorderRadiusGeometry
                            .circular(
                            AppDimensions.radius_8),
                        child: Image.memory(
                            order.items![0].product!.img!,
                            fit: BoxFit.cover,
                            width: MediaQuery.sizeOf(context).width / 2 - 45,
                        ))
                        : Image.asset(
                      getLocalJpeg("burger"),
                      width: MediaQuery.sizeOf(context).width / 2 - 45,
                    )),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width/3+10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.status != OrderStatus.cancelled
                            ? AppLocal.arriving.getString(context)
                            : AppLocal.cancelled.getString(context),
                        style: AppTextStyles.medium16P(
                            color: order.status == OrderStatus.cancelled
                                ? AppColors.errorRed
                                : AppColors.black),
                      ),
                      order.status == OrderStatus.cancelled
                          ? Text(
                              order.statusReason.toString(),
                              style: AppTextStyles.medium14P(),
                              maxLines: 4 ,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
