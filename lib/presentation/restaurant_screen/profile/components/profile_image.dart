import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/restaurant_features/RestaurantDashboard/cubit/res_dashboard_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late ResDashboardCubit rdCubit;

  @override
  void initState() {
    rdCubit = context.read<ResDashboardCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: Utils.vSize(80.0),
                width: Utils.vSize(80.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: Utils.borderRadius(r: 50.0),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(
                        rdCubit.resDashboardModel!.restaurantDisplay!.logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 6,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.editRestaurantProfileScreen);
                  },
                  child: Container(
                    height: 24.h,
                    width: 24.w,
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    child: const CustomImage(path: KImages.editIcon),
                  ),
                ),
              )
            ],
          ),
          Utils.verticalSpace(8.0),
          CustomText(
            text: rdCubit.resDashboardModel?.restaurantDisplay?.name ??
                'Restaurant Name',
            color: blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          Utils.verticalSpace(16.0),
        ],
      ),
    );
  }
}
