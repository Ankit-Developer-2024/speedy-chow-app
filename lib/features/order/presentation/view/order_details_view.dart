import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:speedy_chow/core/components/widgets/button.dart';
import 'package:speedy_chow/core/components/widgets/customLoaderDialog.dart';
import 'package:speedy_chow/core/components/widgets/h_axis_line.dart';
import 'package:speedy_chow/core/enum/enums.dart';
import 'package:speedy_chow/core/localization/app_local.dart';
import 'package:speedy_chow/core/styles/app_colors.dart';
import 'package:speedy_chow/core/styles/app_dimensions.dart';
import 'package:speedy_chow/core/styles/app_text_styles.dart';
import 'package:speedy_chow/core/util/utility/utils.dart';
import 'package:speedy_chow/features/order/presentation/bloc/order_bloc.dart';
import 'package:speedy_chow/core/components/widgets/get_address.dart';

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
            listenWhen: (prev,curr)=> curr is FetchOrderDetailsState,
            listener: (context, state) {
              if(state is FetchOrderDetailsState){
                if(state.loading==true){
                  customLoaderDialog(context: context, title: AppLocal.loading.getString(context));
                }
                else {
                  context.pop();
                }
              }
            },
            buildWhen:(prev,curr)=> curr is FetchOrderDetailsState,
            builder: (context, state) {
              if(state is FetchOrderDetailsState){
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
                      ClipRRect(
                          borderRadius:
                          BorderRadiusGeometry.circular(AppDimensions.radius_8),
                          child: Image.asset(
                            getLocalJpeg("burger"),
                            width: MediaQuery.sizeOf(context).width / 2,
                          )),
                      HAxisLine(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocal.orderedStatus.getString(context),
                                style: AppTextStyles.semiBold20P(),
                              ),
                              Text(
                                context.read<OrderBloc>().getOrderStatus(state.order!.status),
                                style: AppTextStyles.semiBold20P(
                                  color:context.read<OrderBloc>().getOrderStatusColor(state.order!.status)
                                ),
                              ),

                            ],
                          ),
                          state.order?.status == OrderStatus.cancelled
                              ? Text(
                            state.order!.statusReason.toString(),
                            style: AppTextStyles.medium16P(),
                            maxLines: 4 ,
                          )
                              : SizedBox.shrink(),
                        ],
                      ),
                      state.order?.status == OrderStatus.cancelled ? SizedBox(height: AppDimensions.spacing_10,) : SizedBox.shrink(),
                      Text(
                        AppLocal.shippingAddress.getString(context),
                        style: AppTextStyles.semiBold20P(),
                      ),
                      GetAddress(address:state.order?.address, textStyle: null),

                      SizedBox(
                        height: 60,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Button(
                                onTap: () {},
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
                            Button(
                                onTap: () {},
                                width: 110,
                                color: AppColors.errorRed,
                                child: Center(
                                    child: Text(
                                      AppLocal.cancelOrder.getString(context),
                                      style: AppTextStyles.semiBold14P(
                                          color: AppColors.white),
                                    ))),
                          ],
                        ),
                      )
                    ],
                  );
                }
                else {
                  return Center(child:  Text(state.message),);
                }
              }else{
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
