import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/cubit/res_dashboard_cubit.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/cubit/res_dashboard_state.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/model/res_dashboard_model.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/page_refresh.dart';
import 'package:intl/intl.dart';
import '../../../features/restaurant_features/Products/cubit/product_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/title_and_navigator.dart';
import '../my_order/components/order_card.dart';
import 'components/recent_order.dart';
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
  String selectedValue = 'Last 30 days';

  final List<String> items = ['Last 30 days', '1', '2', '3'];

  String getOrderStatusText(dynamic status) {
    switch (status.toString()) {
      case '0':
        return 'Pending';
      case '1':
        return 'Confirmed';
      case '2':
        return 'Preparing';
      case '3':
        return 'Out for Delivery';
      case '4':
        return 'Completed';
      case '5':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  Color getOrderStatusColor(dynamic status) {
    switch (status.toString()) {
      case '0': // Pending
        return const Color(0xFF1F7EFA);
      case '1': // Confirmed
        return Colors.orange;
      case '2': // Preparing
        return Colors.blueGrey;
      case '3': // Out for Delivery
        return Colors.purple;
      case '4': // Completed
        return Colors.green;
      case '5': // Cancelled
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getOrderStatusBgColor(dynamic status) {
    switch (status.toString()) {
      case '0': // Pending
        return const Color(0xFF1F7EFA).withOpacity(0.2);
      case '1': // Confirmed
        return Colors.orange.withOpacity(0.2);
      case '2': // Preparing
        return Colors.blueGrey.withOpacity(0.2);
      case '3': // Out for Delivery
        return Colors.purple.withOpacity(0.2);
      case '4': // Completed
        return Colors.green.withOpacity(0.2);
      case '5': // Cancelled
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.grey;
    }
  }

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
          )
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: "Order Status",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                        DropdownButton<String>(
                          underline: const SizedBox.shrink(),
                          value: selectedValue,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          elevation: 0,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: items
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: CustomText(
                                text: value,
                                color: Colors.black,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    runSpacing: Utils.vSize(10.0),
                    spacing: Utils.vSize(8.0),
                    alignment: WrapAlignment.start,
                    children: [
                      _buildSingleCard(
                        KImages.totalOrder,
                        '${widget.resDashboardModel.statistics?.orderStatistics
                            ?.total ?? 0}',
                        'Total Order',
                        orderTotalColor,
                      ),
                      _buildSingleCard(
                          KImages.activeOrder,
                          '${widget.resDashboardModel.statistics
                              ?.orderStatistics?.active ?? 0}',
                          'Active Order',
                          orderActiveColor),
                      _buildSingleCard(
                          KImages.cancelOrder,
                          '${widget.resDashboardModel.statistics
                              ?.orderStatistics?.cancelled ?? 0}',
                          'Cancelled ',
                          orderCancelledColor.withOpacity(0.2)),
                      _buildSingleCard(
                          KImages.completeOrder,
                          '${widget.resDashboardModel.statistics
                              ?.orderStatistics?.completed ?? 0}',
                          'Complete',
                          orderCompleteColor),
                      _buildSingleCard(
                          KImages.cancelOrder,
                          '${widget.resDashboardModel.statistics
                              ?.orderStatistics?.pending ?? 0}',
                          'Pending',
                          orderCancelledColor.withOpacity(0.2)),
                    ],
                  ),
                  // Utils.verticalSpace(12.0),
                  MyFood(
                    productModel: pCubit.productModel!
                  ),
                  // Utils.verticalSpace(20.0),
                  // RecentOrderCard(),

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
                          onTap: () {},
                          child: const CustomText(
                            text: 'See All',
                            color: greyColor,
                            fontFamily: regular400,
                          ),
                        )
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
                                          horizontal: 16.w, vertical: 12.h),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(6.r)),
                                      child: const OrderDetailsDialog());
                                });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Container(
                              height: 80.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: whiteColor,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //   width: 80.0,
                                  //   height: 80.0,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(10.0),
                                  //     shape: BoxShape.rectangle,
                                  //   ),
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(4.r),
                                  //       bottomLeft: Radius.circular(4.r),
                                  //     ),
                                  //     child: CustomImage(
                                  //       path: RemoteUrls.imageUrl(recentOrders.grandTotal),
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: Utils.symmetric(h: 4.0, v: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const CustomText(
                                              text: "OrderId# ",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: textColor,
                                            ),
                                            CustomText(
                                              text: '${item.id}',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: textColor,
                                            ),
                                            Utils.horizontalSpace(8.0),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(20.r),
                                                color: getOrderStatusBgColor(
                                                    item.orderStatus),
                                              ),
                                              child: Padding(
                                                padding: Utils.symmetric(
                                                    h: 8.0, v: 2.0),
                                                child: CustomText(
                                                    text: getOrderStatusText(
                                                        item.orderStatus),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: getOrderStatusColor(
                                                        item.orderStatus)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Utils.verticalSpace(8.0),
                                        Row(
                                          children: [
                                            CustomText(
                                              text: DateFormat('hh:mm a')
                                                  .format(item.createdAt),
                                              color: textColor,
                                              fontSize: 12,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              child: Container(
                                                height: 5,
                                                width: 5,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: smallContainerColor),
                                              ),
                                            ),
                                            CustomText(
                                              text: Utils.formatDate(
                                                  item.createdAt),
                                              color: textColor,
                                              fontSize: 12,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: Utils.only(right: 8.0),
                                    child: CustomText(
                                      text: Utils.formatPrice(
                                          context, item.grandTotal),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSingleCard(String icon, String count, String title,
      Color bgColor) {
    return Container(
      padding: Utils.symmetric(v: 10.0, h: 8.0),
      height: Utils.vSize(80.0),
      width: Utils.hSize(162.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: borderColor),
        borderRadius: Utils.borderRadius(r: 6.0.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            blurRadius: 60,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: title,
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              CustomText(
                text: count.padLeft(2, '0'),
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: blackColor,
              ),
            ],
          ),
          Container(
            height: Utils.vSize(45.0),
            width: Utils.vSize(45.0),
            margin: Utils.only(left: 8.0, right: 6.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0), color: bgColor),
            child: CustomImage(
              path: icon,
              height: 20.h,
              width: 20.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
