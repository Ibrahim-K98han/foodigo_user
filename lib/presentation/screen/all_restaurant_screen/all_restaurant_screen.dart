import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/HomeData/cubit/home_data_cubit.dart';
import 'package:foodigo/presentation/screen/home/components/top_restaurant.dart';
import 'package:foodigo/widget/custom_appbar.dart';

import '../../../features/HomeData/restaurant_model.dart';
import '../../../utils/utils.dart';

class AllRestaurantScreen extends StatelessWidget {
  const AllRestaurantScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hCubit = context.read<HomeDataCubit>();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'All Restaurant ',
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
            itemCount: hCubit.homeModel!.restaurants!.length,
            padding: Utils.symmetric(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: Utils.only(bottom: 16.0),
                child: TopRestaurantCart(
                  restaurants: hCubit.homeModel!.restaurants![index],
                ),
              );
            }),
      ),
    );
  }
}
