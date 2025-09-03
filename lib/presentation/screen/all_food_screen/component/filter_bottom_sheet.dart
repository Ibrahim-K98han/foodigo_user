import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/HomeData/cubit/home_data_cubit.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../features/AllFood/cubit/all_food_cubit.dart';
import '../../../../features/HomeData/category_model.dart';
import '../../../../features/HomeData/cuisines_model.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late AllFoodCubit searchCubit;
  late HomeDataCubit homeCubit;

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  Set<String> selectedCategoryIds = {};
  Set<String> selectedCuisineIds = {};
  String selectedSort = '';
  int? _minPrice;
  int? _maxPrice;

  @override
  void initState() {
    super.initState();
    searchCubit = context.read<AllFoodCubit>();
    homeCubit = context.read<HomeDataCubit>();

    _searchController.text = searchCubit.search;

    _searchController.addListener(() {
      _onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchCubit.search;
    });
  }

  void _onCategoryChanged(bool? value, Categories cat) {
    setState(() {
      if (value == true) {
        selectedCategoryIds.add(cat.id.toString());
      } else {
        selectedCategoryIds.remove(cat.id.toString());
      }
    });

    final selected = homeCubit.homeModel?.categories
            ?.where((c) => selectedCategoryIds.contains(c.id.toString()))
            .toList() ??
        [];
    searchCubit.categories(selected);
  }

  void _onCuisineChanged(bool? value, Cuisines cuisine) {
    setState(() {
      if (value == true) {
        selectedCuisineIds.add(cuisine.id.toString());
      } else {
        selectedCuisineIds.remove(cuisine.id.toString());
      }
    });

    final selected = homeCubit.homeModel?.cuisines
            ?.where((c) => selectedCuisineIds.contains(c.id.toString()))
            .toList() ??
        [];
    searchCubit.cuisine(selected);
  }

  void _onPriceChanged(RangeValues values) {
    setState(() {
      _minPrice = values.start.toInt();
      _maxPrice = values.end.toInt();
    });

    searchCubit.minPrice.toString();
    searchCubit.maxPrice.toString();
  }

  void _onSortChanged(String sort) {
    setState(() {
      selectedSort = sort;
    });
  }

  void _clearAll() {
    setState(() {
      selectedCategoryIds.clear();
      selectedCuisineIds.clear();
      selectedSort = '';
      _minPrice = null;
      _maxPrice = null;
      _searchController.clear();
    });
    searchCubit.clearFilters();
  }

  @override
  Widget build(BuildContext context) {
    final categories = homeCubit.homeModel?.categories ?? [];
    final cuisines = homeCubit.homeModel?.cuisines ?? [];
    final sorts = [
      'Most Recent',
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search food...",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sort
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: blackColor,
                    title: const CustomText(
                      text: "Sort By",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: sorts.map((sort) {
                      return RadioListTile<String>(
                        activeColor: primaryColor,
                        title: CustomText(
                          text: sort,
                          fontSize: 14,
                        ),
                        value: sort,
                        groupValue: selectedSort,
                        onChanged: (val) {
                          if (val != null) _onSortChanged(val);
                        },
                      );
                    }).toList(),
                  ),
                ),
                // Categories
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      iconColor: blackColor,
                      title: const CustomText(
                        text: "Category",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: categories.map((cat) {
                        return CheckboxListTile(
                          activeColor: primaryColor,
                          title: CustomText(
                            text: cat.name,
                            fontSize: 14,
                          ),
                          value:
                              selectedCategoryIds.contains(cat.id.toString()),
                          onChanged: (val) => _onCategoryChanged(val, cat),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Cuisines
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: blackColor,
                    title: const CustomText(
                      text: "Cuisine",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: cuisines.map((c) {
                      return CheckboxListTile(
                        activeColor: primaryColor,
                        title: CustomText(
                          text: c.name,
                          fontSize: 14,
                        ),
                        value: selectedCuisineIds.contains(c.id.toString()),
                        onChanged: (val) => _onCuisineChanged(val, c),
                      );
                    }).toList(),
                  ),
                ),
                // Price
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: const CustomText(
                    text: "Price Range",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RangeSlider(
                  activeColor: primaryColor,
                  inactiveColor: primaryColor.withOpacity(0.2),
                  values: RangeValues((_minPrice ?? 0).toDouble(),
                      (_maxPrice ?? 100).toDouble()),
                  min: 0,
                  max: 100,
                  divisions: 10,
                  labels: RangeLabels((_minPrice ?? 0).toString(),
                      (_maxPrice ?? 100).toString()),
                  onChanged: _onPriceChanged,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _clearAll,
                      child: const CustomText(
                        text: "Clear All",
                        fontSize: 18,
                        color: redColor,
                      ),
                    ),
                    PrimaryButton(
                      minimumSize: Size(120.w, 45.h),
                      text: 'Search',
                      fontSize: 16,
                      onPressed: () {
                        searchCubit.applyFilters();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullWidthTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackLeft = 0; // Remove extra left padding
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width; // Make full width

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
