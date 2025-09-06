import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/WishList/model/wish_list_model.dart';

import '../repository/wish_list_repository.dart';
import 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final WishListRepository _repository;
  final LoginBloc _loginBloc;

  WishListCubit({
    required WishListRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const WishListInitial());

  WishListModel? wishListModel;

  Future<void> getWishList() async {
    emit(const WishListLoading());

    final result =
        await _repository.getWishList(_loginBloc.userInformation!.token);

    result.fold(
      (l) => emit(WishListError(l.message, l.statusCode)),
      (success) {
        wishListModel = success;
        emit(WishListSuccess(success));
      },
    );
  }

  /// Add product to wishlist
  Future<void> addToWishList(int productId) async {
    emit(const WishListLoading());

    final result = await _repository.addToWishList(
        _loginBloc.userInformation!.token, productId);

    result.fold(
      (l) => emit(WishListError(l.message, l.statusCode)),
      (success) {
        wishListModel = success;
        emit(WishListSuccess(success));
      },
    );
  }

  /// Remove product from wishlist
  Future<void> removeFromWishList(int productId) async {
    emit(const WishListLoading());

    final result = await _repository.removeFromWishList(
        _loginBloc.userInformation!.token, productId);

    result.fold(
      (l) => emit(WishListError(l.message, l.statusCode)),
      (success) {
        wishListModel = success;
        emit(WishListSuccess(success));
      },
    );
  }
}
