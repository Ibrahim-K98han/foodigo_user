import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/Order/model/order_details_model.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/model/res_dashboard_model.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/title_and_navigator.dart';
import '../../../core/routes/route_names.dart';
import '../../my_order/components/order_card.dart';

class RecentOrderCard extends StatelessWidget {
  const RecentOrderCard({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndNavigator(
          title: 'Recent Order',
          seeAllColors: subTitleTextColor,
          press: () {},
        ),
        Utils.verticalSpace(16),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              ...List.generate(5, (index) {
                return Padding(
                  padding:  EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: OrderCart(
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
