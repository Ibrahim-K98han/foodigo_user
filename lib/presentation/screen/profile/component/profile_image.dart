import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late LoginBloc loginBloc;
  late GetProfileCubit pCubit;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  _initState() {
    pCubit = context.read<GetProfileCubit>();
    loginBloc = context.read<LoginBloc>();
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
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: Utils.borderRadius(r: 50.0),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(pCubit.user!.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.editProfileScreen);
                  },
                  child: Container(
                    padding: Utils.all(value: 5.0),
                    height: Utils.vSize(24),
                    width: Utils.vSize(24),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: const Center(
                      child: CustomImage(path: KImages.editIcon),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Utils.verticalSpace(8.0),
          CustomText(
            text: pCubit.user!.name,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          Utils.verticalSpace(16.0),
        ],
      ),
    );
  }
}
