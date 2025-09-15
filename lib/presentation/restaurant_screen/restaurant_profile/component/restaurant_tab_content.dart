import 'package:flutter/material.dart';
import '../../../../../utils/utils.dart';
import '../../../../utils/constraints.dart';
import '../../../../widget/custom_text_style.dart';
import '../../my_menu/my_menu_screen.dart';
import 'best_selling_product.dart';

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
              ),
            ),
          ),
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
                              width: 2),
                        ),
                      ),
                      duration: const Duration(seconds: 0),
                      padding: Utils.symmetric(v: 8.0, h: 10.0),
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
        Expanded(
          child: Container(
            padding: Utils.symmetric(),
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
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.89,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              crossAxisCount: 2),
                      itemCount: 10,
                      itemBuilder: (context, int index) {
                        return const MyMenuCart();
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

// List<Widget> detailScreen = [
//   const BestSellingProduct(),
//   const BestSellingProduct(),
//   const BestSellingProduct(),
//   const BestSellingProduct(),
// ];
final List<String> tabTitle = ['Best Selling', 'Chicken', 'Soup', 'Beverage'];
