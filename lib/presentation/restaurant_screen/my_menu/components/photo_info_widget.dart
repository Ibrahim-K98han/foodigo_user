import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import '../../../../features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import '../../../../utils/k_images.dart';
import '../../../../widget/custom_image.dart';
import '../../restaurant_profile/component/update_product_tile.dart';

class PhotoInfoWidget extends StatefulWidget {
  const PhotoInfoWidget({super.key});

  @override
  State<PhotoInfoWidget> createState() => _PhotoInfoWidgetState();
}

class _PhotoInfoWidgetState extends State<PhotoInfoWidget> {
  late StoreProductCubit stCubit;
  File? _foodImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    stCubit = context.read<StoreProductCubit>();
  }

  Future<void> _pickFoodImage() async {
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
                    _foodImage = File(pickedFile.path);
                  });
                  stCubit.image(pickedFile.path);
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
                    _foodImage = File(pickedFile.path);
                  });
                  stCubit.image(pickedFile.path);
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
      widget: Stack(
        alignment: Alignment.center,
        children: [
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              final stCubit = context.read<StoreProductCubit>();

              final imagePath = (stCubit.products != null &&
                      stCubit.products!.product != null &&
                      stCubit.products!.product!.image.isNotEmpty)
                  ? RemoteUrls.imageUrl(
                      stCubit.products!.product!.image.toString())
                  : KImages.foodImage1;

              return ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: _foodImage != null
                    ? Image.file(
                        _foodImage!,
                        width: 250.w,
                        height: 110.h,
                        fit: BoxFit.cover,
                      )
                    : CustomImage(
                        path: imagePath,
                        width: 250.w,
                        height: 110.h,
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
          Container(
            width: 250.w,
            height: 110.h,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () => _pickFoodImage(),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt, color: Colors.white),
                  SizedBox(height: 4),
                  Text('Upload', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
