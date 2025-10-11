import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/presentation/screen/authentications/components/auth_form.dart';

import '../../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomImage(path: KImages.logo, height: 30.h),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: primaryColor, width: 0.5),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              dividerColor: Colors.transparent,
              labelColor: textColor,
              unselectedLabelColor: primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [Tab(text: "USER"), Tab(text: "RESTAURANT")],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AuthForm(
            title: "Welcome Back!",
            subtitle: "Sign in to your account",
            buttonText: "Sign In",
            isUser: true,
          ),
          AuthForm(
            title: "Restaurant Login",
            subtitle: "Access your restaurant account",
            buttonText: "Sign In",
            isUser: false,
          ),
        ],
      ),
    );
  }
}
