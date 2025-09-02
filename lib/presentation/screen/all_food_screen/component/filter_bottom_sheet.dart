import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/HomeData/cubit/home_data_cubit.dart';
import 'package:foodigo/features/HomeData/cubit/home_data_state.dart';
import 'package:foodigo/features/HomeData/cubit/search_state_model.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';
import 'package:foodigo/presentation/screen/all_food_screen/component/single_expension_tile.dart';
import 'package:foodigo/utils/constraints.dart';

import '../../../../features/HomeData/cubit/search_data_cubit.dart';
import '../../../../features/Login/bloc/login_bloc.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../../widget/fetch_error_text.dart';
import '../../../../widget/primary_button.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late SearchDataCubit searchDataCubit;

  @override
  void initState() {
    searchDataCubit = context.read<SearchDataCubit>();
    searchDataCubit.getSearchAttribute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchDataCubit, SearchStateModel>(
        listener: (context, state) {
      final cars = state.homeDataState;
      if (cars is HomeDataError) {
        if (cars.statusCode == 503 || searchDataCubit.feature.isNotEmpty) {
          Utils.errorSnackBar(context, cars.message);
        }
      }
    }, builder: (context, state) {
      final food = state.homeDataState;
      if (food is HomeDataError) {
        if (food.statusCode == 503 || searchDataCubit.feature.isNotEmpty) {
          return LoadSearchData(food: searchDataCubit.feature);
        } else {
          return FetchErrorText(text: food.message);
        }
      } else if (food is HomeDataLoaded) {
        return LoadSearchData(food: searchDataCubit.feature);
      } else if (food is HomeDataLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (food is HomeDataInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (searchDataCubit.feature.isNotEmpty) {
        return LoadSearchData(food: searchDataCubit.feature);
      } else {
        return LoadSearchData(food: searchDataCubit.feature);
      }
    });
  }
}

class LoadSearchData extends StatefulWidget {
  const LoadSearchData({super.key, required this.food});

  final List<FeaturedProducts> food;

  @override
  State<LoadSearchData> createState() => _LoadSearchDataState();
}

class _LoadSearchDataState extends State<LoadSearchData> {
  late SearchDataCubit searchDataCubit;
  late List<FeaturedProducts> _displayedList;
  late TextEditingController _searchController;
  int? _minPrice;
  int? _maxPrice;
  String? _search;
  String? type;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _displayedList = widget.food;
    searchDataCubit = context.read<SearchDataCubit>();
    _searchController =
        TextEditingController(text: searchDataCubit.state.search);
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel any existing debounce timer
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      if (query.isNotEmpty) {
        searchDataCubit.search(query);
      } else {
        setState(() {
          _displayedList = widget.food;
        });
      }
    });
  }

  void _clearSearch() {
    _searchController.clear(); // Clear input text
    searchDataCubit.clearFilters(); // Clear filters in cubit
    // carsCubit.getAllCarsList(); // Refresh cars list
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: Utils.symmetric(h: 16.0).copyWith(top: 16.0),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const Spacer(),
                    const CustomText(
                      text: 'Search Food',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: greyColor,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CircleAvatar(
                          backgroundColor: redColor,
                          maxRadius: 14.0,
                          child:
                              Icon(Icons.clear, color: whiteColor, size: 20.0)),
                    ),
                  ],
                ),
                Utils.verticalSpace(12.0),
                TextFormField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    contentPadding: Utils.symmetric(v: 14.0, h: 14.0),
                    hintText: 'Food search...',
                    border: OutlineInputBorder(
                      borderRadius: Utils.borderRadius(r: 4.0),
                      borderSide: const BorderSide(color: borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: Utils.borderRadius(r: 4.0),
                      borderSide: const BorderSide(color: borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: Utils.borderRadius(r: 4.0),
                      borderSide: const BorderSide(color: borderColor),
                    ),
                    fillColor: const Color(0xFFFAFAFA),
                    //fillColor: fillColor,
                    filled: true,
                  ),
                ),
                Utils.verticalSpace(12.0),
                SingleExpansionTile(
                  heading: 'Sort By',
                  child: List.generate(5, (index) {
                    return Padding(
                      padding: Utils.symmetric(v: 4.0, h: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: Utils.symmetric(v: 4.0, h: 4.0),
                              // decoration: BoxDecoration(color: redColor),
                              child: const CustomText(
                                  text: 'Most Recent',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: greyColor),
                            ),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              // value: state.staffs.contains(user.id),
                              value: true,
                              // value: addBillCubit.updatedStaffIds.contains(user.id),
                              activeColor: primaryColor,
                              side: const BorderSide(color: Color(0xFFE7E7E7)),
                              // shape: RoundedRectangleBorder(side: BorderSide(color: const Color(0xFFE7E7E7))),
                              onChanged: (val) {
                                // addBillCubit.storeStaffIds(user.id);
                                // print('staff id ${user.id}');
                              },
                              visualDensity: const VisualDensity(
                                horizontal: -4.0,
                                vertical: -4.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Utils.verticalSpace(12.0),
                SingleExpansionTile(
                  heading: 'Category',
                  child: List.generate(5, (index) {
                    return Padding(
                      padding: Utils.symmetric(v: 4.0, h: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: Utils.symmetric(v: 4.0, h: 4.0),
                              // decoration: BoxDecoration(color: redColor),
                              child: const CustomText(
                                  text: 'Category',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: greyColor),
                            ),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              // value: state.staffs.contains(user.id),
                              value: true,
                              // value: addBillCubit.updatedStaffIds.contains(user.id),
                              activeColor: primaryColor,
                              side: BorderSide(color: const Color(0xFFE7E7E7)),
                              // shape: RoundedRectangleBorder(side: BorderSide(color: const Color(0xFFE7E7E7))),
                              onChanged: (val) {
                                // addBillCubit.storeStaffIds(user.id);
                                // print('staff id ${user.id}');
                              },
                              visualDensity: const VisualDensity(
                                horizontal: -4.0,
                                vertical: -4.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Utils.verticalSpace(12.0),
                SingleExpansionTile(
                  heading: 'Select Cuisine',
                  child: List.generate(5, (index) {
                    return Padding(
                      padding: Utils.symmetric(v: 4.0, h: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: Utils.symmetric(v: 4.0, h: 4.0),
                              child: const CustomText(
                                  text: 'Bengli',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: greyColor),
                            ),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              // value: state.staffs.contains(user.id),
                              value: true,
                              // value: addBillCubit.updatedStaffIds.contains(user.id),
                              activeColor: primaryColor,
                              side: BorderSide(color: const Color(0xFFE7E7E7)),
                              // shape: RoundedRectangleBorder(side: BorderSide(color: const Color(0xFFE7E7E7))),
                              onChanged: (val) {
                                // addBillCubit.storeStaffIds(user.id);
                                // print('staff id ${user.id}');
                              },
                              visualDensity: const VisualDensity(
                                horizontal: -4.0,
                                vertical: -4.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Utils.verticalSpace(12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Price Range',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                    ),
                    Utils.verticalSpace(16.0),
                    const CustomText(
                      text: '1000 - 2000',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: greyColor,
                    ),
                    Container(
                      height: Utils.hSize(30.0),
                      margin: Utils.only(bottom: 16.0),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 5.0,
                          trackShape: FullWidthTrackShape(),
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8.0),
                          overlayShape: SliderComponentShape.noOverlay,
                        ),
                        child: RangeSlider(
                          values: const RangeValues(10, 60.0),
                          min: 0,
                          max: 100,
                          activeColor: primaryColor,
                          inactiveColor: greyColor,
                          labels: const RangeLabels('0', '100'),
                          onChanged: (RangeValues values) {},
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: Utils.mediaQuery(context).width,
          // margin: Utils.only(top: 14.0),
          padding: Utils.only(
            left: 16.0,
            right: 16.0,
            top: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(color: whiteColor, boxShadow: boxShadow),
          child: Padding(
            padding: Utils.symmetric(v: 14.0, h: 0.0),
            child: Row(
              children: [
                CustomText(
                  text: 'Clear all',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  decoration: TextDecoration.underline,
                  color: greyColor,
                ),
                Spacer(flex: 2),
                Expanded(
                  flex: 2,
                  child: PrimaryButton(
                      text: 'Search',
                      onPressed: () {
                        searchDataCubit.applyFilters();
                      }),
                )
              ],
            ),
          ),
        ),
      ],
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
