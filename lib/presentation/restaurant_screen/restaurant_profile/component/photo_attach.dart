import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../my_menu/components/edit_food_screen.dart';

class PhotoAttach extends StatefulWidget {
  const PhotoAttach({super.key});

  @override
  State<PhotoAttach> createState() => _PhotoAttachState();
}

class _PhotoAttachState extends State<PhotoAttach> {
  late RestaurantProfileCubit resProCubit;
  File? _logoFile;
  File? _coverFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    resProCubit = context.read<RestaurantProfileCubit>();
  }

  Future<void> _pickLogo() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera, imageQuality: 80);
                if (pickedFile != null) {
                  setState(() {
                    _logoFile = File(pickedFile.path);
                  });
                  resProCubit.logo(pickedFile.path);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 80);
                if (pickedFile != null) {
                  setState(() {
                    _logoFile = File(pickedFile.path);
                  });
                  resProCubit.logo(pickedFile.path);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickCover() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera, imageQuality: 80);
                if (pickedFile != null) {
                  setState(() {
                    _coverFile = File(pickedFile.path);
                  });
                  resProCubit.coverImage(pickedFile.path);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 80);
                if (pickedFile != null) {
                  setState(() {
                    _coverFile = File(pickedFile.path);
                  });
                  resProCubit.coverImage(pickedFile.path);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Photo Attachment',
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Profile Logo',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          Utils.verticalSpace(8),
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () => _pickLogo(),
                child: _logoFile != null
                    ? Image.file(_logoFile!,
                        width: 80, height: 80, fit: BoxFit.cover)
                    : CustomImage(
                        path: resProCubit.restaurantProfileModel!
                                .restaurantProfile!.logo.isNotEmpty
                            ? RemoteUrls.imageUrl(resProCubit
                                .restaurantProfileModel!
                                .restaurantProfile!
                                .logo)
                            : KImages.profile,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _pickLogo(),
                  child: Container(
                    width: 30.w,
                    height: 30.h,
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    child: const CustomImage(path: KImages.camera),
                  ),
                ),
              ),
            ],
          ),
          Utils.verticalSpace(16),
          const CustomText(
            text: 'Cover Photo',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          Utils.verticalSpace(8),
          Stack(
            children: [
              _coverFile != null
                  ? Image.file(_coverFile!,
                      width: 280.w, height: 125.h, fit: BoxFit.cover)
                  : CustomImage(
                      path: resProCubit.restaurantProfileModel!
                              .restaurantProfile!.coverImage.isNotEmpty
                          ? RemoteUrls.imageUrl(resProCubit
                              .restaurantProfileModel!
                              .restaurantProfile!
                              .coverImage)
                          : KImages.foodImage1,
                      width: 280.w,
                      height: 125.h,
                      fit: BoxFit.cover,
                    ),
              Center(
                child: Container(
                  width: 280.w,
                  height: 125.h,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6.r)),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _pickCover(),
                      child: const CustomImage(
                        path: KImages.camera,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
