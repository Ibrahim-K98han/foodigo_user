import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_image.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import 'components/arrival_food.dart';
import 'components/category_list.dart';
import 'components/feature_food.dart';
import 'components/home_header.dart';
import 'components/top_restaurant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final List<String> slider = [KImages.banner];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: Column(
        children: [
          const HomeHeader(),
          Utils.verticalSpace(30.0),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const CategoryList(),
                  Utils.verticalSpace(12.0),
                  const FeatureFood(),
                  Utils.verticalSpace(20.0),
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 164.0,
                          viewportFraction: 1.0,
                          initialPage: _currentIndex,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          autoPlayCurve: Curves.easeInOut,
                          enlargeCenterPage: true,
                          onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: slider.map((e) {
                          return Padding(
                            padding: Utils.symmetric(),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0)),
                              //margin: Utils.symmetric(h: 10.0),
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CustomImage(
                                  path: slider.first,
                                  fit: BoxFit.fill,
                                ),
                                // child: Image.network(e.image),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Positioned(
                          bottom: 10.0,
                          left: 0.0,
                          right: 0.0,
                          child: _buildDotIndicator()),
                    ],
                  ),
                  Utils.verticalSpace(20.0),
                  const TopRestaurant(),
                  Utils.verticalSpace(20.0),
                  const ArrivalFood(),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        slider.length,
            (index) {
          final i = _currentIndex == index;
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: Utils.vSize(6.0),
            width: Utils.hSize(i ? 24.0 : 6.0),
            margin: Utils.only(right: 4.0),
            decoration: BoxDecoration(
              color: i ? primaryColor : whiteColor,
              borderRadius: BorderRadius.circular(i ? 50.0 : 5.0),
              //shape: i ? BoxShape.rectangle : BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}
