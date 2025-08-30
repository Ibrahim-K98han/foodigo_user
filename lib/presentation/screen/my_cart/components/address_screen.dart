import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/address/cubit/get_address_state.dart';
import 'package:foodigo/features/address/model/address_model.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/page_refresh.dart';

import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/fetch_error_text.dart';
import '../../../../widget/loading_widget.dart';
import '../../../core/routes/route_names.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({super.key});

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  late GetAddressCubit addressCubit;

  @override
  void initState() {
    super.initState();
    addressCubit = context.read<GetAddressCubit>();
    addressCubit.getAllAddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Select Address'),
      body: PageRefresh(
        onRefresh: () async {
          addressCubit.getAllAddressData();
        },
        child: BlocConsumer<GetAddressCubit, AllAddressState>(
          listener: (context, state) {
            if (state is AAllAddressError) {
              FetchErrorText(
                text: state.message,
              );
            }
          },
          builder: (context, state) {
            if (state is AllAddressLoading) {
              return const LoadingWidget();
            } else if (state is AAllAddressError) {
              return FetchErrorText(text: state.message);
            } else if (state is AllAddressLoaded) {
              return AddressData(address: addressCubit.getAddress);
            }
            return const Center(child: Text("Something went wrong"));
          },
        ),
      ),
    );
  }
}

class AddressData extends StatefulWidget {
  AddressData({super.key, this.address});

  List<Address>? address;

  @override
  State<AddressData> createState() => _AddressDataState();
}

class _AddressDataState extends State<AddressData> {
  int? selectedAddress;

  @override
  Widget build(BuildContext context) {
    final delete = context.read<GetAddressCubit>();
    return Container(
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
              ...List.generate(widget.address!.length, (index) {
                final address = widget.address![index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAddress = index;
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    GestureDetector(
                                      onTap: () {
                                          delete.deleteAddress(address.id.toString());
                                      },
                                      child: Container(
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
                            AddressWidget(
                                title: 'Full Name:', text: address.name),
                            Utils.verticalSpace(4.0),
                            AddressWidget(title: 'Email:', text: address.email),
                            Utils.verticalSpace(4.0),
                            AddressWidget(title: 'Phone:', text: address.phone),
                            Utils.verticalSpace(4.0),
                            AddressWidget(
                                title: 'Country:', text: address.address),
                            Utils.verticalSpace(4.0),
                            // AddressWidget(
                            //    title: 'State:', text: " Dhaka"),
                            Utils.verticalSpace(4.0),
                            //  AddressWidget(
                            //     title: 'City:', text: " Mirpur"),
                            // Utils.verticalSpace(4.0),
                            // AddressWidget(
                            //     title: 'Address:', text: " Mirpur-10"),
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
                    const Icon(Icons.add),
                    Utils.horizontalSpace(8.0),
                    const CustomText(
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
