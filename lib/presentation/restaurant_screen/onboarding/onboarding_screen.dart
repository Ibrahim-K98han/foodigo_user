import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';
import 'model/onbording_data.dart';
import 'widgets/dot_indicator_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late int _numPages;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _numPages = onBoardingList.length;
    _pageController = PageController(initialPage: _currentPage);
  }

  Widget getContent() {
    final item = onBoardingList[_currentPage];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: ValueKey('$_currentPage'),
      children: [
        CustomText(
          text: item.title,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0C1321),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        CustomText(
          text: item.paragraph,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF475569),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildImagesSlider(),
              _buildBottomContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: kDuration,
            transitionBuilder: (Widget child, Animation<double> anim) {
              return FadeTransition(opacity: anim, child: child);
            },
            child: getContent(),
          ),
          const SizedBox(height: 25),
          _buildBottomButtonIndicator(),
        ],
      ),
    );
  }

  Widget _buildBottomButtonIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DotIndicatiorWidget(
          currentIndex: _currentPage,
          dotNumber: _numPages,
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: const Size(50, 50),
            backgroundColor: primaryColor,
            shape: const CircleBorder(),
          ),
          onPressed: () {
            if (_currentPage == _numPages - 1) {
              //  context.read<AppSettingCubit>().cachOnBoarding();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authenticationScreen, (route) => false);
              return;
            }
            _pageController.nextPage(
                duration: kDuration, curve: Curves.easeInOut);
          },
          child: const Center(
            child: Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }

  Widget _buildImagesSlider() {
    return SizedBox(
      height: size.height / 3,
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children:
            onBoardingList.map((e) => CustomImage(path: e.image)).toList(),
      ),
    );
  }
}
