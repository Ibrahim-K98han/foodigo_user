import 'dart:async';
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
import 'package:foodigo/widget/custom_text_style.dart';
import '../../../features/AllFood/cubit/all_food_state_model.dart';
import '../../../features/HomeData/cubit/home_data_cubit.dart';
import '../../../utils/utils.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/page_refresh.dart';
import 'component/all_food_cart.dart';
import 'component/filter_bottom_sheet.dart';

class AllFoodScreen extends StatefulWidget {
  const AllFoodScreen({super.key});

  @override
  State<AllFoodScreen> createState() => _AllFoodScreenState();
}

class _AllFoodScreenState extends State<AllFoodScreen> {
  late AllFoodCubit allFoodCubit;
  late HomeDataCubit hCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    allFoodCubit = context.read<AllFoodCubit>();
    hCubit = context.read<HomeDataCubit>();
    allFoodCubit.getAllFood();
    hCubit.getHomeDataData();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    if (allFoodCubit.state.initialPage > 1) {
      allFoodCubit.initPage();
    }

    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    debugPrint('scrolling-called');
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0.0) {
        if (allFoodCubit.state.isListEmpty == false) {
          allFoodCubit.getAllFood();
        }
      }
    }
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  builder:
                      (_) => SizedBox(
                        height: 450.h,
                        child: const FilterBottomSheet(),
                      ),
                );
              },
              child: CustomImage(
                path: KImages.filterIcon,
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
          if (allFoodCubit.state.initialPage > 1) {
            allFoodCubit.getAllFood();
          }
          allFoodCubit.getAllFood();
        },
        child: BlocConsumer<AllFoodCubit, AllFoodSearchStateModel>(
          listener: (context, state) {
            final allFood = state.allFoodState;
            if (allFood is AllFoodError) {
              Utils.failureSnackBar(context, allFood.message);
            }
          },
          builder: (context, state) {
            final allFood = state.allFoodState;
            if (allFood is AllFoodLoading) {
              return const LoadingWidget();
            } else if (allFood is AllFoodError) {
              return FetchErrorText(text: allFood.message);
            } else if (allFood is AllFoodLoaded) {
              return LoadFoodData(
                food: allFood.allFood,
                res: hCubit.homeModel!.restaurants!,
                controller: _scrollController,
              ); // Use state.allFood, not cubit.food
            } else if (allFood is AllFoodMoreLoaded) {
              return LoadFoodData(
                food: allFood.allFood,
                res: hCubit.homeModel!.restaurants!,
                controller: _scrollController,
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

class LoadFoodData extends StatefulWidget {
  const LoadFoodData({
    super.key,
    required this.food,
    required this.res,
    required this.controller,
  });

  final List<Foods> food;
  final List<Restaurants> res;
  final ScrollController controller;

  @override
  State<LoadFoodData> createState() => _LoadFoodDataState();
}

class _LoadFoodDataState extends State<LoadFoodData> {
  late AllFoodCubit allFoodCubit;
  late TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    allFoodCubit = context.read<AllFoodCubit>();
    _searchController = TextEditingController(text: allFoodCubit.state.search);
    _searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      if (query.isNotEmpty) {
        allFoodCubit.updateSearch(query);
        allFoodCubit.applyFilters();
      } else {
        setState(() {
          allFoodCubit.getAllFood();
        });
      }
    });
    allFoodCubit.clearFilters();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextFormField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: "Search food...",
              border: const OutlineInputBorder(),
              prefixIcon: Padding(
                padding: EdgeInsets.all(12.r),
                child: const CustomImage(path: KImages.searchIcon),
              ),
            ),
          ),
        ),
        Expanded(
          child:
              widget.food.isEmpty
                  ? const Center(
                    child: CustomText(
                      text: 'No Food Available',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  : ListView.builder(
                    itemCount: widget.food.length,
                    padding: Utils.symmetric(),
                    itemBuilder: (BuildContext context, int index) {
                      final item = widget.food[index];
                      return Padding(
                        padding: Utils.only(bottom: 16.0),
                        child: AllFoodCart(foods: item),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
