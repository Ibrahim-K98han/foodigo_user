import 'package:equatable/equatable.dart';
import 'package:foodigo/features/WishList/model/wish_list_model.dart';

abstract class WishListState extends Equatable {
  const WishListState();

  @override
  List<Object?> get props => [];
}

class WishListInitial extends WishListState {
  const WishListInitial();

  @override
  List<Object?> get props => [];
}

class WishListLoading extends WishListState {
  const WishListLoading();

  @override
  List<Object?> get props => [];
}

class WishListLoaded extends WishListState {
  final WishListModel wishListModel;

  const WishListLoaded(this.wishListModel);

  @override
  List<Object?> get props => [wishListModel];
}

class WishListSuccess extends WishListState {
  final WishListModel wishListModel;

  const WishListSuccess(this.wishListModel);

  @override
  List<Object?> get props => [wishListModel];
}

class WishListError extends WishListState {
  final String message;
  final int statusCode;

  const WishListError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
