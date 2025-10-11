import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/cubit/res_dashboard_cubit.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late ResDashboardCubit rdCubit;

  @override
  void initState() {
    rdCubit = context.read<ResDashboardCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    print(
      RemoteUrls.imageUrl(rdCubit.resDashboardModel!.restaurantDisplay!.logo),
    );
    return SizedBox(
      height: Utils.vSize(size.height * 0.22),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(color: Color(0xFFF6EEEE)),
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      //Utils.horizontalSpace(10),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, RouteNames.editProfile),
                        },
                        child: Container(
                          height: Utils.vSize(52.0),
                          width: Utils.vSize(52.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: CustomImage(
                              path: RemoteUrls.imageUrl(
                                rdCubit
                                    .resDashboardModel!
                                    .restaurantDisplay!
                                    .logo,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Utils.horizontalSpace(10.0),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: 'Welcome',
                              color: Color(0xFF334155),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              text:
                                  rdCubit
                                      .resDashboardModel
                                      ?.restaurantDisplay
                                      ?.name ??
                                  'Restaurant Name',
                              color: blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Utils.horizontalSpace(10),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Utils.horizontalSpace(8.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.editFoodScreen,
                          arguments: '',
                        );
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                          color: redColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.add, size: 35, color: whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -30.0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: double.infinity,
                // height: Utils.vSize(60.0),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: Utils.borderRadius(),
                  border: Border.all(color: borderColor),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 40,
                      offset: Offset(0, 2),
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: Utils.symmetric(v: 20.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "My Balance",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            CustomText(
                              text: Utils.formatPrice(
                                context,
                                rdCubit
                                        .resDashboardModel
                                        ?.statistics
                                        ?.financialStatistics
                                        ?.currentBalance ??
                                    '0',
                              ),
                              color: blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.walletScreen,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: primaryColor,
                            ),
                            child: Padding(
                              padding: Utils.symmetric(h: 10.0, v: 10.0),
                              child: Row(
                                children: [
                                  const CustomImage(
                                    path: KImages.withdraw,
                                    height: 24,
                                  ),
                                  Utils.horizontalSpace(6.0),
                                  const CustomText(
                                    text: 'Withdraw',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
