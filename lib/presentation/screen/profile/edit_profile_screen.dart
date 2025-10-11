import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_state.dart';
import 'package:foodigo/features/GetProfile/model/profile_state_model.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';
import 'package:foodigo/presentation/screen/profile/component/profilee_image.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late GetProfileCubit pCubit;

  @override
  void initState() {
    super.initState();
    pCubit = context.read<GetProfileCubit>();
    pCubit.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(title: 'Edit Profile', visibleLeading: true),
      body: BlocConsumer<GetProfileCubit, ProfileStateModel>(
        listener: (context, state) {
          final profile = state.getProfileState;
          if (profile is UpdateProfileError) {
            if (profile.statusCode == 503) {
              FetchErrorText(text: profile.message);
            } else {
              Utils.errorSnackBar(context, profile.message);
            }
          }
          if (profile is UpdateProfileLoaded) {
            Utils.successSnackBar(context, 'Profile Updated Successfully');
          }
        },
        builder: (context, state) {
          final profile = state.getProfileState;
          if (profile is UpdateProfileLoading) {
            return const LoadingWidget();
          } else if (profile is UpdateProfileError) {
            if (profile.statusCode == 503 || pCubit.user != null) {
              return LoadProfileData(user: pCubit.user!);
            } else {
              return FetchErrorText(text: profile.message);
            }
          } else if (profile is UpdateProfileLoaded) {
            return LoadProfileData(user: pCubit.user!);
          }
          if (pCubit.user != null) {
            return LoadProfileData(user: pCubit.user!);
          } else {
            return const FetchErrorText(text: 'Something Went Wrong');
          }
        },
      ),
    );
  }
}

class LoadProfileData extends StatefulWidget {
  const LoadProfileData({super.key, required this.user});

  final User user;

  @override
  State<LoadProfileData> createState() => _LoadProfileDataState();
}

class _LoadProfileDataState extends State<LoadProfileData> {
  @override
  Widget build(BuildContext context) {
    final pCubit = context.read<GetProfileCubit>();
    return Padding(
      padding: Utils.symmetric(h: 24.0),
      child: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Image
              const ProfileeImage(),

              Utils.verticalSpace(8.0),

              /// Full Name
              BlocBuilder<GetProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return CustomFormWidget(
                    label: 'Full Name',
                    bottomSpace: 14.0,
                    child: TextFormField(
                      initialValue: state.name,
                      onChanged: pCubit.name,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF8FAFC),
                        filled: true,
                        hintText: 'Full name',
                      ),
                    ),
                  );
                },
              ),

              /// Email
              BlocBuilder<GetProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return CustomFormWidget(
                    label: 'Email',
                    bottomSpace: 14.0,
                    child: TextFormField(
                      initialValue: state.email,
                      onChanged: pCubit.email,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF8FAFC),
                        filled: true,
                        hintText: 'Email',
                      ),
                    ),
                  );
                },
              ),

              /// Phone Number
              BlocBuilder<GetProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return CustomFormWidget(
                    label: 'Phone Number',
                    bottomSpace: 14.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: state.phone,
                      onChanged: pCubit.phone,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF8FAFC),
                        filled: true,
                        hintText: 'Phone number',
                      ),
                    ),
                  );
                },
              ),

              Utils.verticalSpace(16.0),

              /// Address
              BlocBuilder<GetProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return CustomFormWidget(
                    label: 'Address',
                    bottomSpace: 14.0,
                    child: TextFormField(
                      initialValue: state.address,
                      onChanged: pCubit.address,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF8FAFC),
                        filled: true,
                        hintText: 'Mirpur-10, Dhaka-1216',
                      ),
                    ),
                  );
                },
              ),

              Utils.verticalSpace(45.0),

              /// Update button
              PrimaryButton(
                text: 'Update Profile',
                onPressed: () {
                  pCubit.updateProfile();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
