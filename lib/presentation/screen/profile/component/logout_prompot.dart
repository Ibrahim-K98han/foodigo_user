import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_event.dart';
import 'package:foodigo/features/Login/bloc/login_state.dart';
import 'package:foodigo/features/Login/model/login_state_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/feedback_dialog.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/primary_button.dart';

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
                      return Center(
                        child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: const LoadingWidget(),
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
