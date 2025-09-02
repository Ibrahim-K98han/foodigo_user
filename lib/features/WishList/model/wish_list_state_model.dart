import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/WishList/cubit/wish_list_state.dart';

class WishListStateModel extends Equatable {
  final int productId;
  final WishListState wishListState;

  const WishListStateModel({
    this.productId = 0,
    this.wishListState = const WishListInitial(),
  });

  WishListStateModel copyWith({
    int? productId,
    WishListState? wishListState,
  }) {
    return WishListStateModel(
      productId: productId ?? this.productId,
      wishListState: wishListState ?? this.wishListState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
    };
  }

  factory WishListStateModel.fromMap(Map<String, dynamic> map) {
    return WishListStateModel(
      productId: map['product_id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishListStateModel.fromJson(String source) =>
      WishListStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [productId, wishListState];
}
