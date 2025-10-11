import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/cubit/res_dashboard_cubit.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/cubit/res_dashboard_state.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/model/res_dashboard_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/presentation/restaurant_screen/home/components/build_single_card.dart';
import 'package:foodigo/presentation/restaurant_screen/home/components/recent_order_card.dart';
import 'package:foodigo/presentation/restaurant_screen/main_page/component/restaurant_main_controller.dart';
import 'package:foodigo/widget/page_refresh.dart';

import '../../../features/restaurant_features/Products/cubit/product_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';
import '../my_order/components/order_details_screen.dart';
import 'components/feature_food.dart';
import 'components/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ResDashboardCubit rdCubit;

  @override
  void initState() {
    super.initState();
    rdCubit = context.read<ResDashboardCubit>();
    final productCubit = context.read<ProductCubit>();
    if (productCubit.productModel == null) {
      productCubit.getProduct();
    }
    rdCubit.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageRefresh(
        onRefresh: () async {
          rdCubit.getDashboardData();
        },
        child: BlocConsumer<ResDashboardCubit, ResDashboardState>(
          listener: (context, state) {
            final dashboard = state;
            if (dashboard is ResDashboardError) {
              if (dashboard.statusCode == 503) {
                FetchErrorText(text: dashboard.message);
              }
            }
          },
          builder: (context, state) {
            final dashboard = state;
            if (dashboard is ResDashboardLoading) {
              return const LoadingWidget();
            } else if (dashboard is ResDashboardError) {
              if (dashboard.statusCode == 503 ||
                  rdCubit.resDashboardModel != null) {
                return DashboardDataLoad(
                  resDashboardModel: rdCubit.resDashboardModel!,
                );
              } else {
                return FetchErrorText(text: dashboard.message);
              }
            } else if (dashboard is ResDashboardLoaded) {
              return DashboardDataLoad(
                resDashboardModel: rdCubit.resDashboardModel!,
              );
            }
            if (rdCubit.resDashboardModel != null) {
              return DashboardDataLoad(
                resDashboardModel: rdCubit.resDashboardModel!,
              );
            } else {
              return const FetchErrorText(text: 'Something Went Wrong');
            }
          },
        ),
      ),
    );
  }
}

class DashboardDataLoad extends StatefulWidget {
  const DashboardDataLoad({super.key, required this.resDashboardModel});

  final ResDashboardModel resDashboardModel;

  @override
  State<DashboardDataLoad> createState() => _DashboardDataLoadState();
}

class _DashboardDataLoadState extends State<DashboardDataLoad> {
  @override
  Widget build(BuildContext context) {
    final pCubit = context.read<ProductCubit>();
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 40,
            offset: Offset(0, 2),
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          const HomeHeader(),
          Utils.verticalSpace(30.0),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: Utils.symmetric(v: 6.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Order Status",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    runSpacing: Utils.vSize(10.0),
                    spacing: Utils.vSize(8.0),
                    alignment: WrapAlignment.start,
                    children: [
                      BuildSingleCard(
                        title: 'Total Order',
                        count:
                            '${widget.resDashboardModel.statistics?.orderStatistics?.total ?? 0}',
                        icon: KImages.totalOrder,
                        bgColor: orderTotalColor,
                      ),
                      BuildSingleCard(
                        title: 'Active Order',
                        count:
                            '${widget.resDashboardModel.statistics?.orderStatistics?.active ?? 0}',
                        icon: KImages.activeOrder,
                        bgColor: orderActiveColor,
                      ),
                      BuildSingleCard(
                        title: 'Cancelled',
                        count:
                            '${widget.resDashboardModel.statistics?.orderStatistics?.cancelled ?? 0}',
                        icon: KImages.cancelOrder,
                        bgColor: orderCancelledColor.withOpacity(0.2),
                      ),
                      BuildSingleCard(
                        title: 'Complete',
                        count:
                            '${widget.resDashboardModel.statistics?.orderStatistics?.completed ?? 0}',

                        icon: KImages.completeOrder,
                        bgColor: orderCompleteColor,
                      ),
                      BuildSingleCard(
                        title: 'Pending',
                        count:
                            '${widget.resDashboardModel.statistics?.orderStatistics?.pending ?? 0}',
                        icon: KImages.cancelOrder,
                        bgColor: orderCancelledColor.withOpacity(0.2),
                      ),
                    ],
                  ),
                  // Utils.verticalSpace(12.0),
                  pCubit.productModel == null
                      ? const CustomText(text: 'Data Not Found')
                      : MyFood(productModel: pCubit.productModel!),

                  Padding(
                    padding: Utils.symmetric(h: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: 'Recent Order',
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.restaurantMainScreen,
                              (route) => false,
                            );
                            Future.delayed(Duration(milliseconds: 100), () {
                              RestaurantMainController().changeTab(2);
                            });
                          },
                          child: const CustomText(
                            text: 'See All',
                            color: greyColor,
                            fontFamily: regular400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: Utils.symmetric(h: 20.0, v: 0.0),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.resDashboardModel.recentOrder!.length,
                      itemBuilder: (context, index) {
                        final item =
                            widget.resDashboardModel.recentOrder![index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: OrderDetailsDialog(
                                    orderId: item.id.toString(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: RecentOrderCard(item: item),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
