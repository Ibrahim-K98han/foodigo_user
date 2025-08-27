import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/presentation/screen/home/components/arrival_food.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';

import '../../../features/HomeData/cubit/home_data_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import 'component/filter_bottom_sheet.dart';

class AllFoodScreen extends StatelessWidget {
  const AllFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hCubit = context.read<HomeDataCubit>();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'All Food ',
        action: [
          Padding(
            padding: Utils.only(right: 20),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    //useSafeArea: true,
                    backgroundColor: whiteColor,
                    constraints: BoxConstraints.loose(
                      Size(Utils.mediaQuery(context).width,
                          Utils.mediaQuery(context).height * 0.9),
                    ),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Utils.radius(16.0)),
                            topRight: Radius.circular(Utils.radius(16.0)))),
                    builder: (context) =>
                        const IntrinsicHeight(child: FilterBottomSheet()));
              },
              child: CustomImage(
                path: KImages.filterFood,
                width: 24.w,
                height: 24.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: Container(
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
        child: ListView.builder(
            itemCount: hCubit.homeModel!.newArrivalProducts!.length,
            padding: Utils.symmetric(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: Utils.only(bottom: 16.0),
                child: FoodCart(
                  newArrivalProducts:
                      hCubit.homeModel!.newArrivalProducts![index],
                ),
              );
            }),
      ),
    );
  }
}
