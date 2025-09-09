import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/address/cubit/get_address_state.dart';
import 'package:foodigo/features/address/model/address_state_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/page_refresh.dart';
import 'package:foodigo/widget/primary_button.dart';
import '../../../../features/address/model/address_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
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
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(),
        child: PrimaryButton(
          text: 'Add Address',
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouteNames.editAddressScreen,
              arguments: {"isEdit": false},
            );
          },
        ),
      ),
      body: PageRefresh(
        onRefresh: () async => addressCubit.getAllAddressData(),
        child: BlocBuilder<GetAddressCubit, AddressStateModel>(
          builder: (context, state) {
            final addressState = state.addressState;
            List<Address> addresses = [];
            if (addressState is AllAddressLoading) {
              return const LoadingWidget();
            } else if (addressState is AAllAddressError) {
              return FetchErrorText(text: addressState.message);
            } else if (addressState is AllAddressLoaded) {
              addresses = addressState.getAddress;
              if (addresses.isEmpty) {
                return const Center(
                    child: Text("No Address Found Please Add Address"));
              }
            }
            return SingleChildScrollView(
              child: Padding(
                padding: Utils.symmetric(),
                child: Column(
                  children: [
                    ...addresses.map(
                          (address) =>
                          AddressItem(
                            address: address,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.orderScreen,
                                  arguments: address);
                            },
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.address, required this.onTap});

  final Address address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetAddressCubit>();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: Utils.symmetric(v: 10.0, h: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Billing Address',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteNames.editAddressScreen,
                              arguments: {
                                'id': address.id,
                              });
                        },
                        child: const CustomImage(
                            path: KImages.editIcon, height: 25),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          cubit.deleteAddress('${address.id}');
                        },
                        child: BlocBuilder<GetAddressCubit, AddressStateModel>(
                          builder: (context, state) {
                            final deleteState = state.addressState;
                            if (deleteState is DeleteAddressLoading &&
                                deleteState.addressId ==
                                    address.id.toString()) {
                              return const LoadingWidget();
                            }
                            return const CustomImage(
                                path: KImages.deleteIcon, height: 25);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Utils.verticalSpace(10.0),
              AddressWidget(title: 'Full Name:', text: address.name),
              AddressWidget(title: 'Email:', text: address.email),
              AddressWidget(title: 'Phone:', text: address.phone),
              AddressWidget(title: 'Address:', text: address.address),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  final String text;
  final String title;

  const AddressWidget({
    super.key,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: blackColor.withOpacity(0.7),
        ),
        Flexible(
          child: CustomText(
            text: text,
            maxLine: 2,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: blackColor,
          ),
        ),
      ],
    );
  }
}
