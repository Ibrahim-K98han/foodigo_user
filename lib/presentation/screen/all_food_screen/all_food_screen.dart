import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/AllFood/cubit/all_food_cubit.dart';
import 'package:foodigo/features/AllFood/cubit/all_food_state.dart';
import 'package:foodigo/features/AllFood/model/all_food_model.dart';
import 'package:foodigo/features/HomeData/restaurant_model.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';

import '../../../features/HomeData/cubit/home_data_cubit.dart';
import '../../../utils/utils.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/page_refresh.dart';
import 'component/all_food_cart.dart';
import 'component/filter_bottom_sheet.dart';

class AllFoodScreen extends StatefulWidget {
  const AllFoodScreen({
    super.key,
  });

  @override
  State<AllFoodScreen> createState() => _AllFoodScreenState();
}

class _AllFoodScreenState extends State<AllFoodScreen> {
  late AllFoodCubit allFoodCubit;
  late HomeDataCubit hCubit;

  @override
  void initState() {
    allFoodCubit = context.read<AllFoodCubit>();
    hCubit = context.read<HomeDataCubit>();
    allFoodCubit.getAllFood();
    hCubit.getHomeDataData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (_) => const SizedBox(
                    height: 600,
                    child: FilterBottomSheet(),
                  ),
                );
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
      body: PageRefresh(
        onRefresh: () async {
          allFoodCubit.getAllFood();
        },
        child: BlocConsumer<AllFoodCubit, AllFoodState>(
          listener: (context, state) {
            if (state is AllFoodError) {
              Utils.failureSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AllFoodLoading) {
              return const LoadingWidget();
            } else if (state is AllFoodError) {
              return FetchErrorText(text: state.message);
            } else if (state is AllFoodLoaded) {
              return LoadFoodData(
                food: state.allFood,
                res: hCubit.homeModel!.restaurants!,
              ); // Use state.allFood, not cubit.food
            } else if (state is AllFoodMoreLoaded) {
              return LoadFoodData(
                  food: state.allFood.foods ?? [],
                  res: hCubit.homeModel!.restaurants!);
            } else {
              return const FetchErrorText(text: 'Something Went Wrong');
            }
          },
        ),
      ),
    );
  }
}

class LoadFoodData extends StatefulWidget {
  const LoadFoodData({super.key, required this.food, required this.res});

  final List<Foods> food;
  final List<Restaurants> res;

  @override
  State<LoadFoodData> createState() => _LoadFoodDataState();
}

class _LoadFoodDataState extends State<LoadFoodData> {
  @override
  Widget build(BuildContext context) {
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
      child: ListView.builder(
        itemCount: widget.food.length,
        padding: Utils.symmetric(),
        itemBuilder: (BuildContext context, int index) {
          final item = widget.food[index];
          return Padding(
            padding: Utils.only(bottom: 16.0),
            child: AllFoodCart(
              foods: item,
              restaurants: widget.res[index],
            ),
          );
        },
      ),
    );
  }
}
