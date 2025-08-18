import 'package:flutter/material.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../core/routes/route_names.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({super.key});

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  int? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Select Address'),
      body: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 40,
              offset: Offset(0, 2),
              spreadRadius: 10,
            )
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: Utils.symmetric(),
            child: Column(
              children: [
                ...List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAddress = index; // Update selected index on tap
                      });
                    },
                    child: Padding(
                      padding: Utils.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: selectedAddress == index
                                  ? const Color(
                                      0xFFE94222) // Selected border color (red)
                                  : borderColor,
                            ),
                            color: whiteColor),
                        child: Padding(
                          padding: Utils.symmetric(v: 10.0, h: 10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: 'Billing Address#1',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteNames.editAddressScreen);
                                        },
                                        child: Container(
                                          padding: Utils.all(value: 6.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border:
                                                Border.all(color: borderColor),
                                          ),
                                          child: const Center(
                                            child: CustomImage(
                                              path: KImages.editIcon,
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Utils.horizontalSpace(8.0),
                                      Container(
                                        padding: Utils.all(value: 6.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: const Color(0xFFE94222)
                                                .withOpacity(0.4),
                                          ),
                                        ),
                                        child: const Center(
                                          child: CustomImage(
                                            path: KImages.deleteIcon,
                                            height: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Utils.verticalSpace(10.0),
                              Container(
                                height: 0.5,
                                width: double.infinity,
                                color: const Color(0xFFE94222).withOpacity(0.5),
                              ),
                              Utils.verticalSpace(10.0),
                              const AddressWidget(
                                  title: 'Full Name:', text: " Jost Batler"),
                              Utils.verticalSpace(4.0),
                              const AddressWidget(
                                  title: 'Email:',
                                  text: " jostbatler@gmail.com"),
                              Utils.verticalSpace(4.0),
                              const AddressWidget(
                                  title: 'Phone:', text: " 0147855852"),
                              Utils.verticalSpace(4.0),
                              const AddressWidget(
                                  title: 'Country:', text: " Bangladesh"),
                              Utils.verticalSpace(4.0),
                              const AddressWidget(
                                  title: 'State:', text: " Dhaka"),
                              Utils.verticalSpace(4.0),
                              const AddressWidget(
                                  title: 'City:', text: " Mirpur"),
                              Utils.verticalSpace(4.0),
                              const AddressWidget(
                                  title: 'Address:', text: " Mirpur-10"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.editAddressScreen);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      Utils.horizontalSpace(8.0),
                      CustomText(
                        text: 'Add new',
                        decoration: TextDecoration.underline,
                      ),
                    ],
                  ),
                ),
                Utils.verticalSpace(20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.text,
    required this.title,
  });

  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: blackColor.withOpacity(0.7),
        ),
        CustomText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: blackColor,
        ),
      ],
    );
  }
}
