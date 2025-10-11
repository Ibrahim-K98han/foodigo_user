import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/WishList/cubit/wish_list_cubit.dart';
import 'package:foodigo/features/WishList/cubit/wish_list_state.dart';

import '../../../../data/remote_url.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../core/routes/route_names.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late GetProfileCubit pCubit;
  late WishListCubit wishCubit;
  late LoginBloc loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initState();
  }

  _initState() {
    pCubit = context.read<GetProfileCubit>();
    wishCubit = context.read<WishListCubit>();
    wishCubit.getWishList();
    loginBloc = context.read<LoginBloc>();
    // if (pCubit.user?.image.isNotEmpty ?? false) {
    //   image = RemoteUrls.imageUrl(pCubit.user!.image);
    // } else {
    //   image = KImages.profile;
    // }
  }

  @override
  Widget build(BuildContext context) {
    print("name is ${pCubit.user?.name}");
    print(RemoteUrls.imageUrl(pCubit.user!.image));
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      height: Utils.vSize(size.height * 0.20),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: Utils.vSize(size.height * 0.2),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(color: Color(0xFFF6EEEE)),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      //Utils.horizontalSpace(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.editProfileScreen,
                          );
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
                              path: RemoteUrls.imageUrl(pCubit.user!.image),
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
                            CustomText(
                              text: pCubit.user?.name ?? '',
                              color: blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                              text: pCubit.user?.address ?? '',
                              color: blackColor.withOpacity(0.8),
                              fontSize: 13,
                              fontFamily: regular400,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.wishlistScreen);
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: whiteColor, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: BlocBuilder<WishListCubit, WishListState>(
                            builder: (context, state) {
                              final wishListCubit =
                                  context.read<WishListCubit>();
                              final items =
                                  wishListCubit
                                      .wishListModel
                                      ?.data
                                      ?.wishlistItems ??
                                  [];

                              final count = items.length;

                              return badges.Badge(
                                showBadge: true,
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: redColor,
                                  padding: EdgeInsets.all(4.r),
                                ),
                                position: badges.BadgePosition.topEnd(
                                  top: -10,
                                  end: -12,
                                ),
                                badgeContent: CustomText(
                                  text: count.toString(),
                                  fontSize: 10,
                                  color: whiteColor,
                                ),
                                child: const CustomImage(
                                  path: KImages.loveIcon,
                                  height: 20,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -35,
            left: 0,
            right: 0,
            child: Padding(
              padding: Utils.symmetric(),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.allFoodScreen);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CustomImage(path: KImages.searchIcon),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.allFoodScreen,
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CustomImage(path: KImages.filterIcon),
                        ),
                      ),
                      hintText: 'Search',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 12.0,
                      ),
                      filled: true,
                      fillColor: whiteColor,
                      border: InputBorder.none,
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
