import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_state.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/primary_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late GetProfileCubit pCubit;
  @override
  void initState() {
    pCubit = context.read<GetProfileCubit>();
    super.initState();
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context); // close the sheet
                pickFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context); // close the sheet
                pickFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(title: 'Edit Profile', visibleLeading: true),
      body: Padding(
        padding: Utils.symmetric(
          h: 24.0,
        ),
        child: ListView(
          children: [
            Column(
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
                        child: _image != null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                            : const CustomImage(
                                path: KImages.userImage,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _showImageSourceDialog(context);
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
                            child: CustomImage(
                              path: KImages.camera,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Utils.verticalSpace(8.0),
                BlocBuilder<GetProfileCubit, GetProfileState>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Full Name',
                      bottomSpace: 14.0,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          fillColor: Color(0xffF8FAFC),
                          filled: true,
                          hintText: 'Full name',
                        ),
                      ),
                    );
                  },
                ),
                CustomFormWidget(
                  label: 'Email',
                  bottomSpace: 14.0,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0xffF8FAFC),
                      filled: true,
                      hintText: 'Email',
                    ),
                  ),
                ),
                CustomFormWidget(
                  label: 'Phone Number',
                  bottomSpace: 14.0,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0xffF8FAFC),
                      filled: true,
                      hintText: 'Phone number',
                    ),
                  ),
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: 'Gender',
                      fontWeight: FontWeight.w500,
                      color: settingsIconBgColor,
                    )),
                Utils.verticalSpace(16.0),
                CustomFormWidget(
                  label: 'Address',
                  bottomSpace: 14.0,
                  child: TextFormField(
                    maxLines: 4,
                    decoration: const InputDecoration(
                      fillColor: Color(0xffF8FAFC),
                      filled: true,
                      hintText: 'Mirpur-10, Dhaka-1216',
                    ),
                  ),
                ),
                Utils.verticalSpace(45.0),
                PrimaryButton(text: 'Update Profile', onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
