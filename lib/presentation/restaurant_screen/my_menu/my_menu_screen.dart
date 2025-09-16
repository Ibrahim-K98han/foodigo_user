import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../core/routes/route_names.dart';
import '../product_details/product_details_screen.dart';

class MyMenuScreen extends StatefulWidget {
  const MyMenuScreen({super.key});

  @override
  State<MyMenuScreen> createState() => _MyMenuScreenState();
}

class _MyMenuScreenState extends State<MyMenuScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Food Menu',
        visibleLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
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
                                  width: 2),
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.89,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                crossAxisCount: 2),
                        itemCount: 9,
                        itemBuilder: (context, int index) {
                          return const MyMenuCart();
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, RouteNames.editFoodScreen);
        },
        backgroundColor: redColor,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}

final List<String> tabTitle = ['Best Selling', 'Chicken', 'Soup', 'Beverage'];

class MyMenuCart extends StatelessWidget {
  const MyMenuCart({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RouteNames.productDetailsScreen);
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          backgroundColor: whiteColor,
          constraints: BoxConstraints.loose(
            Size(
              Utils.mediaQuery(context).width,
              Utils.mediaQuery(context).height * 0.9,
            ),
          ),
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Utils.radius(10.0)),
              topRight: Radius.circular(Utils.radius(10.0)),
            ),
          ),
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: const ProductDetailsScreen(),
              );
            },
          ),
        );
      },
      child: Container(
        //  height: 220.0,
        width: 240.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align children to the start
          children: [
            Stack(
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  child: CustomImage(
                    path: KImages.foodImage1,
                    fit: BoxFit.fill,
                    height: 90,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, RouteNames.editFoodScreen);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: whiteColor, shape: BoxShape.circle),
                      child: Padding(
                        padding: Utils.all(value: 4.0),
                        child: const Center(
                            child: CustomImage(
                          path: KImages.editIcon,
                          width: 16,
                          height: 16,
                          color: redColor,
                        )),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: Utils.symmetric(v: 8.0, h: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align children to the start
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Add space between price and rating
                    children: [
                      const CustomText(
                        text: "\$25.00",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: redColor,
                      ),
                      Row(
                        children: [
                          const CustomImage(path: KImages.star),
                          Utils.horizontalSpace(4.0),
                          const CustomText(
                            text: '4.9 ',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          const CustomText(
                            text: '(5k+)',
                            color: subTitleTextColor,
                            fontSize: 13,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Utils.verticalSpace(4.0),
                  const CustomText(
                    text: 'Sandwiches Strawberry',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    maxLine: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
