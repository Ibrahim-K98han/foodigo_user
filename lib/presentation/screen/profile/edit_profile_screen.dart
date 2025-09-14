import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_state.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/primary_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late GetProfileCubit pCubit;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  /// controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pCubit = context.read<GetProfileCubit>();
    pCubit.getProfileData();
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() => _image = File(image.path));
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _image = File(image.path));
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
                Navigator.pop(context);
                pickFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
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
        padding: Utils.symmetric(h: 24.0),
        child: BlocListener<GetProfileCubit, GetProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccess) {
              Utils.successSnackBar(context, 'Profile updated successfully');
              context.read<GetProfileCubit>().getProfileData();
            } else if (state is UpdateProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              if (state is GetProfileLoaded) {
                final user = state.user;

                nameController.text = user.name;
                emailController.text = user.email;
                phoneController.text = user.phone;
                addressController.text = user.address;

                return ListView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Profile Image
                        Stack(
                          children: [
                            Container(
                              height: Utils.vSize(80.0),
                              width: Utils.vSize(80.0),
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: Utils.borderRadius(r: 50.0),
                                child: _image != null
                                    ? Image.file(_image!, fit: BoxFit.cover)
                                    : const CustomImage(
                                        path: KImages.profile,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _showImageSourceDialog(context),
                                child: Container(
                                  padding: Utils.all(value: 5.0),
                                  height: Utils.vSize(24),
                                  width: Utils.vSize(24),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: const Center(
                                    child: CustomImage(path: KImages.camera),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        Utils.verticalSpace(8.0),

                        /// Full Name
                        CustomFormWidget(
                          label: 'Full Name',
                          bottomSpace: 14.0,
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              fillColor: Color(0xffF8FAFC),
                              filled: true,
                              hintText: 'Full name',
                            ),
                          ),
                        ),

                        /// Email
                        CustomFormWidget(
                          label: 'Email',
                          bottomSpace: 14.0,
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              fillColor: Color(0xffF8FAFC),
                              filled: true,
                              hintText: 'Email',
                            ),
                          ),
                        ),

                        /// Phone Number
                        CustomFormWidget(
                          label: 'Phone Number',
                          bottomSpace: 14.0,
                          child: TextFormField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                              fillColor: Color(0xffF8FAFC),
                              filled: true,
                              hintText: 'Phone number',
                            ),
                          ),
                        ),

                        /// Gender label
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: 'Gender',
                            fontWeight: FontWeight.w500,
                            color: settingsIconBgColor,
                          ),
                        ),
                        Utils.verticalSpace(16.0),

                        /// Address
                        CustomFormWidget(
                          label: 'Address',
                          bottomSpace: 14.0,
                          child: TextFormField(
                            controller: addressController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              fillColor: Color(0xffF8FAFC),
                              filled: true,
                              hintText: 'Mirpur-10, Dhaka-1216',
                            ),
                          ),
                        ),

                        Utils.verticalSpace(45.0),

                        /// Update button
                        PrimaryButton(
                          text: 'Update Profile',
                          onPressed: () {
                            final updatedUser = {
                              "name": nameController.text,
                              "email": emailController.text,
                              "phone": phoneController.text,
                              "address": addressController.text,
                            };
                            context
                                .read<GetProfileCubit>()
                                .updateProfile(updatedUser);
                          },
                        )
                      ],
                    )
                  ],
                );
              } else if (state is GetProfileError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: LoadingWidget());
            },
          ),
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: whiteColor,
//     appBar: const CustomAppBar(title: 'Edit Profile', visibleLeading: true),
//     body: Padding(
//       padding: Utils.symmetric(h: 24.0),
//       child: BlocBuilder<GetProfileCubit, GetProfileState>(
//         builder: (context, state) {
//           if (state is UpdateProfileSuccess) {
//             const LoadingWidget();
//             context.read<GetProfileCubit>().getProfileData();
//           } else if (state is GetProfileLoaded) {
//             final user = state.user;
//             nameController.text = user.name;
//             emailController.text = user.email;
//             phoneController.text = user.phone;
//             addressController.text = user.address;
//
//             return ListView(
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     /// Profile Image
//                     Stack(
//                       children: [
//                         Container(
//                           height: Utils.vSize(80.0),
//                           width: Utils.vSize(80.0),
//                           decoration:
//                               const BoxDecoration(shape: BoxShape.circle),
//                           child: ClipRRect(
//                             borderRadius: Utils.borderRadius(r: 50.0),
//                             child: _image != null
//                                 ? Image.file(_image!, fit: BoxFit.cover)
//                                 : const CustomImage(
//                                     path: KImages.profile,
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: GestureDetector(
//                             onTap: () => _showImageSourceDialog(context),
//                             child: Container(
//                               padding: Utils.all(value: 5.0),
//                               height: Utils.vSize(24),
//                               width: Utils.vSize(24),
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: primaryColor,
//                               ),
//                               child: const Center(
//                                 child: CustomImage(path: KImages.camera),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//
//                     Utils.verticalSpace(8.0),
//
//                     /// Full Name
//                     CustomFormWidget(
//                       label: 'Full Name',
//                       bottomSpace: 14.0,
//                       child: TextFormField(
//                         controller: nameController,
//                         decoration: const InputDecoration(
//                           fillColor: Color(0xffF8FAFC),
//                           filled: true,
//                           hintText: 'Full name',
//                         ),
//                       ),
//                     ),
//
//                     /// Email
//                     CustomFormWidget(
//                       label: 'Email',
//                       bottomSpace: 14.0,
//                       child: TextFormField(
//                         controller: emailController,
//                         decoration: const InputDecoration(
//                           fillColor: Color(0xffF8FAFC),
//                           filled: true,
//                           hintText: 'Email',
//                         ),
//                       ),
//                     ),
//
//                     /// Phone Number
//                     CustomFormWidget(
//                       label: 'Phone Number',
//                       bottomSpace: 14.0,
//                       child: TextFormField(
//                         controller: phoneController,
//                         decoration: const InputDecoration(
//                           fillColor: Color(0xffF8FAFC),
//                           filled: true,
//                           hintText: 'Phone number',
//                         ),
//                       ),
//                     ),
//
//                     /// Gender label
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: CustomText(
//                         text: 'Gender',
//                         fontWeight: FontWeight.w500,
//                         color: settingsIconBgColor,
//                       ),
//                     ),
//                     Utils.verticalSpace(16.0),
//
//                     /// Address
//                     CustomFormWidget(
//                       label: 'Address',
//                       bottomSpace: 14.0,
//                       child: TextFormField(
//                         controller: addressController,
//                         maxLines: 4,
//                         decoration: const InputDecoration(
//                           fillColor: Color(0xffF8FAFC),
//                           filled: true,
//                           hintText: 'Mirpur-10, Dhaka-1216',
//                         ),
//                       ),
//                     ),
//
//                     Utils.verticalSpace(45.0),
//
//                     /// Update button
//                     PrimaryButton(
//                       text: 'Update Profile',
//                       onPressed: () {
//                         final updatedUser = {
//                           "name": nameController.text,
//                           "email": emailController.text,
//                           "phone": phoneController.text,
//                           "address": addressController.text,
//                         };
//                         context
//                             .read<GetProfileCubit>()
//                             .updateProfile(updatedUser);
//                       },
//                     )
//                   ],
//                 )
//               ],
//             );
//           } else if (state is GetProfileError) {
//             return Center(child: Text(state.message));
//           }
//           return const SizedBox();
//         },
//       ),
//     ),
//   );
// }
}
