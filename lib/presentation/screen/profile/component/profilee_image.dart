import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:image_picker/image_picker.dart';

class ProfileeImage extends StatefulWidget {
  const ProfileeImage({super.key});

  @override
  State<ProfileeImage> createState() => _ProfileeImageState();
}

class _ProfileeImageState extends State<ProfileeImage> {
  late GetProfileCubit pCubit;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    pCubit = context.read<GetProfileCubit>();
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        _image = File(pickedFile.path);
                      });
                      pCubit.image(pickedFile.path);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        _image = File(pickedFile.path);
                      });
                      pCubit.image(pickedFile.path);
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
    return Stack(
      alignment: Alignment.center,
      children: [
        _image != null
            ? ClipRRect(
              borderRadius: Utils.borderRadius(r: 50.0),
              child: Image.file(
                _image!,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
              ),
            )
            : ClipRRect(
              borderRadius: Utils.borderRadius(r: 50.0),
              child: CustomImage(
                path:
                    pCubit.user!.image.isNotEmpty
                        ? RemoteUrls.imageUrl(pCubit.user!.image)
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
            onTap: () => _pickImage(),
            child: Container(
              width: 20.w,
              height: 20.h,
              padding: EdgeInsets.all(4.r),
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: const CustomImage(path: KImages.camera),
            ),
          ),
        ),
      ],
    );
  }
}
