import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/customLoader.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/h_axis_line.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/features/order/presentation/bloc/order_bloc.dart';
import 'package:speedy_chow/features/order/presentation/widgets/error_msg_widget.dart';
import 'package:speedy_chow/features/order/presentation/widgets/order_detail_info.dart';
import 'package:speedy_chow/features/order/presentation/widgets/order_detail_item.dart';
import 'package:speedy_chow/features/order/presentation/widgets/order_details_button.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  bool _isInit = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!_isInit){
      _isInit=true;
      Map<String, String> orderId = GoRouterState.of(context).pathParameters;
      if(orderId['id'] != null){
        context.read<OrderBloc>().add(FetchOrderDetailsEvent(id: orderId['id']!));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.grey10.withAlpha(100),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            size: AppDimensions.size_18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.spacing_24,
            right: AppDimensions.spacing_24,
            top: AppDimensions.spacing_10,
          ),
          child: BlocConsumer<OrderBloc, OrderState>(
            listenWhen: (prev,curr)=> curr is FetchOrderDetailsState || curr is UpdateOrderState ,
            listener: (context, state) {
              if(state is FetchOrderDetailsState){
                if(state.loading==true){
                  customLoaderDialog(context: context, title: AppLocal.loading.getString(context));
                }
                else {
                  context.pop();
                }
              }
              if(state is UpdateOrderState){
                if(state.loading==true){
                  customLoader(context: context);
                }
                else {
                  context.pop();
                }
              }
            },
            buildWhen:(prev,curr)=> curr is FetchOrderDetailsState || curr is UpdateOrderState ,
            builder: (context, state) {
              if(state is FetchOrderDetailsState){
                if(state.loading==true){
                  return SizedBox.shrink();
                }
                else if(state.success==true && state.order!=null){
                   return SingleChildScrollView(
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppDimensions.spacing_10,
                      children: [
                       Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.order!.status!=OrderStatus.cancelled ? AppLocal.arriving.getString(context) : AppLocal.cancelled.getString(context),
                              style: AppTextStyles.semiBold18P(),
                            ),
                            TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text(
                                  AppLocal.seeAllOrders.getString(context),
                                  style: AppTextStyles.medium14P(
                                      color: AppColors.darkOrange),
                                ))
                          ],
                        ),
                       OrderDetailItem(items: state.order!.items!),
                       HAxisLine(),
                       OrderDetailInfo(order: state.order!),
                        OrderDetailsButton(order: state.order!),
                      ],
                     ),
                   );
                }
                else {
                  return ErrorMsgWidget(msg: state.message);
                }
              }
              else if(state is UpdateOrderState){
                if(state.loading==true){
                  return SizedBox.shrink();
                }
                else if(state.success==true && state.order!=null){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppDimensions.spacing_10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.order!.status!=OrderStatus.cancelled ? AppLocal.arriving.getString(context) : AppLocal.cancelled.getString(context),
                            style: AppTextStyles.semiBold18P(),
                          ),
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                AppLocal.seeAllOrders.getString(context),
                                style: AppTextStyles.medium14P(
                                    color: AppColors.darkOrange),
                              ))
                        ],
                      ),
                      OrderDetailItem(items: state.order!.items!),
                      HAxisLine(),
                      OrderDetailInfo(order: state.order!),
                      OrderDetailsButton(order: state.order!),
                    ],
                  );
                }
                else {
                  return  ErrorMsgWidget(msg: state.message);
                }
              }
              else{
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}