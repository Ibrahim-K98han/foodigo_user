import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/HomeData/home_data_model.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';
import 'package:foodigo/widget/page_refresh.dart';

import '../../../features/HomeData/cubit/home_data_cubit.dart';
import '../../../features/HomeData/cubit/home_data_state.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';
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
  late HomeDataCubit homeDataCubit;
  late UserResponseModel userResponseModel;

  @override
  initState() {
    super.initState();
    homeDataCubit = context.read<HomeDataCubit>();
    homeDataCubit.getHomeDataData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageRefresh(
        onRefresh: () async {
          homeDataCubit.getHomeDataData();
        },
        child: BlocConsumer<HomeDataCubit, HomeDataState>(
          listener: (context, state) {
            final home = state;
            if (home is HomeDataError) {
              if (home.statusCode == 503) {
                FetchErrorText(text: home.message);
              }
            }
          },
          builder: (context, state) {
            final home = state;
            if (home is HomeDataLoading) {
              return const LoadingWidget();
            } else if (home is HomeDataError) {
              if (home.statusCode == 503 || homeDataCubit.homeModel != null) {
                return LoadedHomeData(
                  homeModel: homeDataCubit.homeModel!,
                );
              } else {
                return FetchErrorText(text: home.message);
              }
            } else if (home is HomeDataLoaded) {
              return LoadedHomeData(
                homeModel: homeDataCubit.homeModel!,
              );
            }
            if (homeDataCubit.homeModel != null) {
              return LoadedHomeData(
                homeModel: homeDataCubit.homeModel!,
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

class LoadedHomeData extends StatelessWidget {
  const LoadedHomeData({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

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
      child: Column(
        children: [
          const HomeHeader(),
          // Utils.verticalSpace(30.0),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  CategoryList(
                    categories: homeModel.categories!,
                  ),
                  // Utils.verticalSpace(12.0),
                  FeatureFood(
                    featuredProducts: homeModel.featuredProducts!,
                    restaurant: homeModel.restaurants!,
                  ),
                  Utils.verticalSpace(20.0),

                  ///============= Banner Slider =============///
                  BannerSlider(),
                  Utils.verticalSpace(20.0),
                  TopRestaurant(
                    restaurants: homeModel.restaurants!,
                  ),
                  Utils.verticalSpace(20.0),
                  ArrivalFood(
                    newArrivalProducts: homeModel.newArrivalProducts!,
                    restaurant: homeModel.restaurants!,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BannerSlider extends StatelessWidget {
  int _currentIndex = 1;
  final List<String> slider = [KImages.banner];

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            onPageChanged: (index, reason) {},
            scrollDirection: Axis.horizontal,
          ),
          items: slider.map((e) {
            return Padding(
              padding: Utils.symmetric(),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
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
        // Positioned(
        //   bottom: 10.0,
        //   left: 0.0,
        //   right: 0.0,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: List.generate(
        //       slider.length,
        //       (index) {
        //         final i = _currentIndex == index;
        //         return AnimatedContainer(
        //           duration: const Duration(seconds: 1),
        //           height: Utils.vSize(6.0),
        //           width: Utils.hSize(i ? 24.0 : 6.0),
        //           margin: Utils.only(right: 4.0),
        //           decoration: BoxDecoration(
        //             color: i ? primaryColor : whiteColor,
        //             borderRadius: BorderRadius.circular(i ? 50.0 : 5.0),
        //             //shape: i ? BoxShape.rectangle : BoxShape.circle,
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
