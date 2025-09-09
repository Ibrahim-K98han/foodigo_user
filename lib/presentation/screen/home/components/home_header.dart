import 'package:badges/badges.dart' as badges;
import 'package:dartz/dartz.dart' as product;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_state.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/WishList/cubit/wish_list_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../core/routes/route_names.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late GetProfileCubit pCubit;
  late LoginBloc loginBloc;
  late String image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initState();
  }

  _initState() {
    pCubit = context.read<GetProfileCubit>();
    loginBloc = context.read<LoginBloc>();
    if (pCubit.user?.image.isNotEmpty ?? false) {
      image = RemoteUrls.imageUrl(pCubit.user!.image);
    } else {
      image = KImages.profile;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("name is ${loginBloc.userInformation!.user!.name}");
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<GetProfileCubit, GetProfileState>(
      builder: (context, state) {
        String image;
        String name;
        String address;
        if (state is GetProfileLoaded) {
          if (state.user.image.isNotEmpty) {
            image = RemoteUrls.imageUrl(state.user.image);
          } else {
            image = KImages.profile;
          }
          name = state.user.name ?? "";
          address = state.user.address ?? "";
        } else {
          image = KImages.profile;
          name = loginBloc.userInformation?.user?.name ?? "Guest";
          address = loginBloc.userInformation?.user?.address ?? "Guest";
        }
        return SizedBox(
          height: Utils.vSize(size.height * 0.20),
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: Utils.vSize(size.height * 0.2),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF6EEEE),
                ),
                margin: const EdgeInsets.only(bottom: 10),
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
                                  path: image,
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
                                  text: name,
                                  color: blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                CustomText(
                                  text: address,
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
                            Navigator.pushNamed(
                                context, RouteNames.wishlistScreen);
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: whiteColor, width: 1.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                                child: CustomImage(
                              path: KImages.loveIcon,
                              height: 20,
                            )),
                          ),
                        ),
                        Utils.horizontalSpace(8.0),
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: whiteColor, width: 1.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: badges.Badge(
                              position: badges.BadgePosition.topEnd(
                                  top: -10, end: -0),
                              badgeContent: const Text(''),
                              child: const CustomImage(
                                path: KImages.notificationIcon,
                                height: 25,
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
                bottom: -18.0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: Utils.symmetric(),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CustomImage(path: KImages.searchIcon),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.allFoodScreen);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CustomImage(path: KImages.filterIcon),
                          ),
                        ),
                        hintText: 'Search',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 12.0),
                        filled: true,
                        fillColor: whiteColor,
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
