import 'package:flutter/material.dart';
import 'package:foodigo/features/SingleRestaurant/model/single_restaurant_model.dart';
import '../../../../../utils/utils.dart';
import '../../../../utils/constraints.dart';
import '../../../../widget/custom_text_style.dart';
import 'best_selling_screen.dart';

class RestaurantTabContents extends StatefulWidget {
  const RestaurantTabContents(
      {super.key, required this.restaurantDetailsModel});

  final RestaurantDetailsModel restaurantDetailsModel;

  @override
  State<RestaurantTabContents> createState() => _RestaurantTabContentsState();
}

class _RestaurantTabContentsState extends State<RestaurantTabContents> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: borderColor,
              ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.restaurantDetailsModel.categories.length,
                (index) {
                  final active = _currentIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _currentIndex = index),
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: active
                                  ? const Color(0xFFE94222)
                                  : Colors.transparent,
                              width: 2),
                        ),
                      ),
                      duration: const Duration(seconds: 0),
                      padding: Utils.symmetric(v: 8.0, h: 12.0),
                      child: CustomText(
                        text: widget
                            .restaurantDetailsModel.categories[index].name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: regular400,
                        color: blackColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Expanded(
            child: BestSellingProduct(
          products:
              widget.restaurantDetailsModel.categories[_currentIndex].products,
        )),
      ],
    );
  }
}
