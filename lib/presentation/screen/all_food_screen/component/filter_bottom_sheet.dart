import 'package:flutter/material.dart';
import 'package:foodigo/presentation/screen/all_food_screen/component/single_expension_tile.dart';
import 'package:foodigo/utils/constraints.dart';

import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../../widget/primary_button.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
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
                      child: CircleAvatar(
                          backgroundColor: redColor,
                          maxRadius: 14.0,
                          child: const Icon(Icons.clear,
                              color: whiteColor, size: 20.0)),
                    ),
                  ],
                ),
                Utils.verticalSpace(12.0),
                TextFormField(
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
                    CustomText(
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
                  child: PrimaryButton(text: 'Search', onPressed: () {}),
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
