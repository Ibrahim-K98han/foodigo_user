import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Order/cubit/order_cubit.dart';
import 'package:foodigo/features/Order/cubit/order_state.dart';
import 'package:foodigo/features/Order/model/order_model.dart';
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

    tabController = TabController(length: 6, vsync: this); // 6 টি স্ট্যাটাস
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  // order_status → label mapping
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
        // TabBar
        Material(
          color: scaffoldBgColor,
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            labelColor: whiteColor,
            unselectedLabelColor: blackColor,
            indicator: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            tabs: statusMap.values
                .map((label) => Tab(text: label))
                .toList(),
          ),
        ),
        // TabBarView
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: statusMap.keys.map((status) {
              final filteredOrders = orders.where((order) {
                final statusValue = int.tryParse(order.orderStatus ?? "");
                return statusValue == status;
              }).toList();
              if (filteredOrders.isEmpty) {
                return const Center(
                  child: CustomText(
                    text: "No Orders Found",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                shrinkWrap: true, // 👈 ListView height issue fix
                physics: const BouncingScrollPhysics(), // 👈 safe scrolling
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];

                  // 👇 null safe status parse
                  final statusValue = int.tryParse(order.orderStatus ?? "0") ?? 0;

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
