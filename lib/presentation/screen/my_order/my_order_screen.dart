import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Order/cubit/order_cubit.dart';
import 'package:foodigo/features/Order/cubit/order_state.dart';
import 'package:foodigo/features/Order/model/order_model.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/page_refresh.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/loading_widget.dart';
import 'components/order_card.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with TickerProviderStateMixin {
  late OrderCubit orderCubit;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    orderCubit = context.read<OrderCubit>();
    orderCubit.getOrderData();

    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: const CustomAppBar(
        bgColor: Color(0xFFF6F8FA),
        title: 'My Orders',
        visibleLeading: false,
      ),
      body: PageRefresh(
        onRefresh: () async {
          orderCubit.getOrderData();
        },
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderStateLoading) {
              return const LoadingWidget();
            } else if (state is OrderStateError &&
                state.statusCode != 503 &&
                orderCubit.orders.isEmpty) {
              return FetchErrorText(text: state.message);
            }

            return LoadOrderData(
              orders: orderCubit.orders,
              tabController: tabController,
            );
          },
        ),
      ),
    );
  }
}

class LoadOrderData extends StatelessWidget {
  const LoadOrderData({
    super.key,
    required this.orders,
    required this.tabController,
  });

  final List<OrderModel> orders;
  final TabController tabController;

  static const Map<int, String> statusMap = {
    1: "Pending",
    2: "Confirmed",
    3: "Processing",
    4: "On the Way",
    5: "Delivered",
    6: "Canceled",
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          isScrollable: true,
          indicator: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryColor),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: statusMap.values.map((label) {
            return Tab(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: CustomText(
                  text: label,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: statusMap.keys.map((status) {
              final filteredOrders = orders.where((order) {
                final statusValue = int.tryParse(order.orderStatus);
                return statusValue == status;
              }).toList();
              if (filteredOrders.isEmpty) {
                return const Center(
                  child: CustomImage(path: KImages.cartNotFound),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return Padding(
                    padding: Utils.symmetric(h: 20.0, v: 6.0),
                    child: OrderCard(orderModel: order),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
