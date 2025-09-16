import 'package:flutter/material.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';
import '../../core/routes/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotToNext();
  }

  gotToNext() {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.authenticationScreen, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return const Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Center(
        child: SizedBox(
          height: 50,
          width: 220,
          child: CustomImage(
            path: KImages.logo,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
