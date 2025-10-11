import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/Splash/cubit/splash_cubit.dart';
import 'package:foodigo/features/Splash/cubit/splash_state.dart';
import 'package:foodigo/features/Splash/model/splash_response_model.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';
import '../../core/routes/route_names.dart';
import 'widgets/dot_indicator_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late SplashCubit spCubit;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    spCubit = context.read<SplashCubit>();
    spCubit.getSplash();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const CustomImage(
          path: KImages.logo,
          height: 30,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authenticationScreen, (route) => false);
            },
            child: const CustomText(
              text: 'skip',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              if (state is SplashStateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SplashStateError) {
                return Center(child: Text(state.message));
              } else if (state is SplashStateLoaded) {
                final screens = spCubit.splashResponseModel!.splashScreens;
                if (screens.isEmpty) {
                  return const Center(
                      child: Text("No onboarding data available"));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildImagesSlider(screens, size),
                    _buildBottomContent(screens),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImagesSlider(List<One> screens, Size size) {
    return SizedBox(
      height: size.height / 3,
      child: PageView.builder(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return CustomImage(path: RemoteUrls.imageUrl(screens[index].image));
        },
      ),
    );
  }

  Widget _buildBottomContent(List<One> screens) {
    final item = screens[_currentPage];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: kDuration,
            transitionBuilder: (child, anim) =>
                FadeTransition(opacity: anim, child: child),
            child: Column(
              key: ValueKey(_currentPage),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: item.heading,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0C1321),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                CustomText(
                  text: item.subheading,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF475569),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          _buildBottomButtonIndicator(screens.length),
        ],
      ),
    );
  }

  Widget _buildBottomButtonIndicator(int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DotIndicatiorWidget(
          currentIndex: _currentPage,
          dotNumber: totalPages,
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: const Size(50, 50),
            backgroundColor: primaryColor,
            shape: const CircleBorder(),
          ),
          onPressed: () {
            if (_currentPage == totalPages - 1) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authenticationScreen, (route) => false);
              return;
            }
            _pageController.nextPage(
                duration: kDuration, curve: Curves.easeInOut);
          },
          child: const Center(child: Icon(Icons.arrow_forward)),
        ),
      ],
    );
  }
}
