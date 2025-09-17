import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/Order/cubit/order_state.dart';
import 'package:foodigo/features/restaurant_features/Order/cubit/res_order_cubit.dart';
import 'package:foodigo/features/restaurant_features/Order/cubit/res_order_state.dart';
import 'package:foodigo/features/restaurant_features/Order/model/res_order_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/page_refresh.dart';
import 'package:intl/intl.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import 'components/res_order_card.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with TickerProviderStateMixin {
  late ResOrderCubit orCubit;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    orCubit = context.read<ResOrderCubit>();
    orCubit.getAllOrder();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Orders',
        visibleLeading: false,
      ),
      body: PageRefresh(
        onRefresh: () async {
          orCubit.getAllOrder();
        },
        child: BlocBuilder<ResOrderCubit, ResOrderState>(
          builder: (context, state) {
            if (state is ResOrderLoading) {
              return const LoadingWidget();
            } else if (state is ResOrderError &&
                state.statusCode != 503 &&
                orCubit.resOrderModel!.isEmpty) {
              return FetchErrorText(text: state.message);
            }
            return LoadedAllOrderData(
              orders: orCubit.resOrderModel!,
              tabController: tabController,
            );
          },
        ),
      ),
    );
  }
}

class LoadedAllOrderData extends StatelessWidget {
  const LoadedAllOrderData({
    super.key,
    required this.orders,
    required this.tabController,
  });

  final List<ResOrderModel> orders;
  final TabController tabController;

  static const Map<int, String> statusMap = {
    1: "Pending",
    2: "Confirmed",
    3: "Processing",
    4: "On The Way",
    5: "Delivered",
    6: "Cancelled",
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          controller: tabController,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.transparent,
          labelColor: textColor,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          unselectedLabelColor: Colors.black,
          tabs: statusMap.values.map((label) {
            return Tab(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: CustomText(text: label, fontSize: 14),
              ),
            );
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: statusMap.keys.map((status) {
              final filteredOrders = orders.where((order) {
                final statusValue = int.tryParse(order.orderStatus ?? "0");
                return statusValue == status;
              }).toList();

              if (filteredOrders.isEmpty) {
                return const Center(
                  child: CustomImage(path: KImages.cartNotFound),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    color: greyColor.withOpacity(0.2),
                  );
                },
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.0),
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final item = filteredOrders[index];
                  return ResOrderCard(order: item);
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
