
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/WishList/cubit/wish_list_cubit.dart';
import 'package:foodigo/features/WishList/cubit/wish_list_state.dart';
import 'package:foodigo/features/WishList/model/wish_list_model.dart';
import 'package:foodigo/presentation/screen/home/components/wish_card.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/page_refresh.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/fetch_error_text.dart';
import '../../../../widget/loading_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late WishListCubit wishListCubit;

  @override
  void initState() {
    super.initState();
    wishListCubit = context.read<WishListCubit>();
    wishListCubit.getWishList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Wishlist'),
        body: PageRefresh(
          onRefresh: () async {
            wishListCubit.getWishList();
          },
          child: BlocConsumer<WishListCubit, WishListState>(
            listener: (context, state) {
              final wishList = state;
              if (wishList is WishListError) {
                if (wishList.statusCode == 503) {
                  FetchErrorText(text: wishList.message);
                }
              }
            },
            builder: (context, state) {
              final wishList = state;

              if (wishList is WishListLoading) {
                return const LoadingWidget();
              } else if (wishList is WishListError) {
                if (wishList.statusCode == 503 ||
                    wishListCubit.wishListModel != null) {
                  final items =
                      wishListCubit.wishListModel?.data?.wishlistItems ?? [];
                  if (items.isEmpty) {
                    return const Center(
                      child: CustomText(
                        text: "Wishlist is Empty",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    );
                  }
                  return LoadWishListData(
                      wishListModel: wishListCubit.wishListModel!);
                } else {
                  return FetchErrorText(text: wishList.message);
                }
              } else if (wishList is WishListSuccess) {
                final items =
                    wishListCubit.wishListModel?.data?.wishlistItems ?? [];
                if (items.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "Wishlist is Empty",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  );
                }
                return LoadWishListData(
                    wishListModel: wishListCubit.wishListModel!);
              }

              if (wishListCubit.wishListModel != null) {
                final items =
                    wishListCubit.wishListModel?.data?.wishlistItems ?? [];
                if (items.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "Wishlist is Empty",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  );
                }
                return LoadWishListData(
                    wishListModel: wishListCubit.wishListModel!);
              } else {
                return const FetchErrorText(text: 'Something Went Wrong');
              }
            },
          ),
        ));
  }
}

class LoadWishListData extends StatelessWidget {
  const LoadWishListData({super.key, required this.wishListModel});

  final WishListModel wishListModel;

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: Utils.symmetric(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(wishListModel.data!.wishlistItems!.length,
                  (index) {
                return Padding(
                  padding: Utils.only(bottom: 12.0),
                  child: WishCard(
                    wishlistItem: wishListModel.data!.wishlistItems![index],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
