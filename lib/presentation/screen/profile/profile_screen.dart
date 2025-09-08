import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_event.dart';
import 'package:foodigo/features/Login/bloc/login_state.dart';
import 'package:foodigo/features/Login/model/login_state_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import '../../../data/remote_url.dart';
import '../../../features/GetProfile/cubit/get_profile_state.dart';
import '../../../features/Login/model/user_response_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';
import '../../../widget/feedback_dialog.dart';
import '../../../widget/primary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Profile",
        visibleLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          const ProfileImage(),
          SliverList(
              delegate: SliverChildListDelegate([
            DrawerItem(
              title: "Personal Info",
              icon: KImages.profileInActive,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.editProfileScreen);
              },
            ),
            DrawerItem(
              title: "Payment Method",
              icon: KImages.dollarBag,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.paymentMethodScreen,
                    arguments: '1');
              },
            ),
            DrawerItem(
                title: "Settings",
                icon: KImages.settingIcon,
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.settingScreen);
                }),
            DrawerItem(
                title: "Address",
                icon: KImages.location,
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.addressScreen);
                }),
            DrawerItem(
                title: "Help Center",
                icon: KImages.help,
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.faqScreen);
                }),
            DrawerItem(
                title: "Change Password",
                icon: KImages.unlock,
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteNames.profilePasswordChangeScreen);
                }),
            Utils.verticalSpace(40.0),
            SwitchWidget(
              text: 'Notification',
              initialValue: true,
              onToggle: (bool value) {},
            ),
            Utils.verticalSpace(40.0),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LogoutPrompt());
              },
              child: Padding(
                padding: Utils.symmetric(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: const Color(0xFFF01543).withOpacity(0.4),
                    ),
                  ),
                  child: Padding(
                    padding: Utils.symmetric(h: 20.0, v: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomImage(path: KImages.logout),
                        Utils.horizontalSpace(8.0),
                        const CustomText(
                          text: "Logout",
                          fontSize: 16,
                          color: redColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Utils.verticalSpace(10),
          ])),
        ],
      ),
    );
  }
}

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late LoginBloc loginBloc;
  late GetProfileCubit pCubit;
  late String image;

  @override
  void initState() {
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
    return BlocBuilder<GetProfileCubit, GetProfileState>(
      builder: (context, state) {
        String image;
        String name;
        if (state is GetProfileLoaded) {
          if (state.user.image.isNotEmpty) {
            image = RemoteUrls.imageUrl(state.user.image);
          } else {
            image = KImages.profile;
          }
          name = state.user.name ?? "";
        } else {
          image = KImages.profile;
          name = loginBloc.userInformation?.user?.name ?? "Guest";
        }

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
                        path: image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.editProfileScreen,
                        );
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
                text: name,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              Utils.verticalSpace(16.0),
            ],
          ),
        );
      },
    );
  }
}

class LogoutPrompt extends StatelessWidget {
  const LogoutPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedBackDialog(
      image: KImages.logoutImage,
      message: "Are you sure you want Logout ?",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Not now',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  borderRadiusSize: 4.0,
                  isGradient: false,
                  bgColor: blackColor,
                  textColor: whiteColor,
                  fontSize: 16.0,
                  minimumSize: Size(Utils.hSize(150.0), Utils.vSize(30.0)),
                  maximumSize: Size(Utils.hSize(150.0), Utils.vSize(30.0)),
                ),
              ),
              Utils.horizontalSpace(20),
              Expanded(
                child: BlocConsumer<LoginBloc, LoginStateModel>(
                  listener: (context, state) {
                    if (state.loginState is LoginStateLogoutLoaded) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteNames.authenticationScreen,
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.loginState is LoginStateLogoutLoading) {
                      return const Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: redColor,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
                    return PrimaryButton(
                      text: 'Logout',
                      onPressed: () {
                        context.read<LoginBloc>().add(const LoginEventLogout());
                      },
                      bgColor: redColor,
                      textColor: whiteColor,
                      borderRadiusSize: 4.0,
                      fontSize: 16.0,
                      minimumSize: Size(Utils.hSize(150.0), Utils.vSize(30.0)),
                      maximumSize: Size(Utils.hSize(150.0), Utils.vSize(30.0)),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isVisibleBorder = true,
    this.version = false,
  });

  final String icon;
  final String title;
  final bool isVisibleBorder;
  final bool version;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(v: 20.0).copyWith(top: 0.0, bottom: 20.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomImage(
                      path: icon,
                      fit: BoxFit.cover,
                      color: const Color(0xff0C1321),
                      height: 26,
                    ),
                    Utils.horizontalSpace(12.0),
                    CustomText(
                      text: title,
                      color: const Color(0xff0C1321),
                      fontSize: 16.0,
                      fontFamily: regular400,
                    ),
                  ],
                ),
                version
                    ? const CustomText(
                        text: '1.0.0',
                        color: blackColor,
                        fontSize: 16.0,
                        fontFamily: bold700,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          isVisibleBorder
              ? Container(
                  height: 1.0,
                  width: double.infinity,
                  margin: Utils.only(right: 20.0, top: 20.0),
                  color: greyColor.withOpacity(0.1),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    super.key,
    this.text,
    required this.initialValue,
    required this.onToggle,
    this.widget,
  });

  final String? text;
  final bool initialValue;
  final ValueChanged<bool> onToggle;
  final Widget? widget;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  void _toggle() {
    setState(() => isOn = !isOn);
    widget.onToggle(isOn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.only(left: 24),
      child: Row(
        children: [
          const CustomText(
            text: 'Switch to Seller',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          Utils.horizontalSpace(12),
          GestureDetector(
            onTap: _toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 50,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // color: isOn ? textColor : Colors.grey.shade400,
                  border: Border.all(
                      color: isOn ? redColor : Colors.grey.shade400, width: 2)),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 100),
                alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
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
