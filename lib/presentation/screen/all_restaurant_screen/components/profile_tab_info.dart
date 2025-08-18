import 'package:flutter/material.dart';
import '../../../../../utils/utils.dart';
import '../../../../utils/constraints.dart';
import '../../../../widget/custom_text_style.dart';
import 'best_selling_screen.dart';

class RestaurantTabContents extends StatefulWidget {
  const RestaurantTabContents({super.key});

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
          ))),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                tabTitle.length,
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
                              width: 2
                        ),

                        ),
                      ),
                      duration: const Duration(seconds: 0),
                      padding: Utils.symmetric(v: 8.0, h: 12.0),
                      child: CustomText(
                        text: tabTitle[index],
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
        const Expanded(child: BestSellingProduct()),
      ],
    );
  }
}

// List<Widget> detailScreen = [
//   const BestSellingProduct(),
//   const BestSellingProduct(),
//   const BestSellingProduct(),
//   const BestSellingProduct(),
// ];
final List<String> tabTitle = ['Best Selling', 'Chicken', 'Soup', 'Beverage'];
