import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';
import '../model/cart_model.dart';
import '../model/cart_state_model.dart';
import '../repository/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartStateModel> {
  final CartRepository _repository;
  final LoginBloc _loginBloc;

  CartCubit({
    required CartRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const CartStateModel());

  CartModel? cartModel;

  Future<void> getCartData() async {
    emit(state.copyWith(cartState: CartLoading()));
    // final result = await _repository.getCartData();
    final uri = Utils.tokenWithCode(
      RemoteUrls.getCartData,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Cart======$uri');
    final result =
        await _repository.getCartData(_loginBloc.userInformation!.token);
    result.fold(
      (l) =>
          emit(state.copyWith(cartState: CartError(l.message, l.statusCode))),
      (success) {
        cartModel = success;
        emit(state.copyWith(cartState: CartLoaded(success)));
      },
    );
  }

  ///Delete Product
  Future<void> deleteProduct(String productId) async {
    emit(state.copyWith(cartState: CartDeleteLoading()));
    final result = await _repository.deleteProduct(
      _loginBloc.userInformation!.token,
      productId,
    );
    result.fold(
      (l) => emit(
          state.copyWith(cartState: CartDeleteError(l.message, l.statusCode))),
      (success) {
        cartModel = success;
        emit(state.copyWith(cartState: CartDeleteSuccess(success)));
      },
    );
  }

  /// Increment product quantity
  Future<void> incrementProduct(String productId) async {
    // emit(state.copyWith(cartState: CartIncrementLoading()));
    final result = await _repository.incrementProduct(
      cartModel!,
      productId,
      _loginBloc.userInformation!.token,
    );
    result.fold(
      (l) =>
          emit(state.copyWith(cartState: CartError(l.message, l.statusCode))),
      (success) {
        // preserve product details from the old cartModel
        final updatedItems = success.cartItems?.map((newItem) {
          final oldItem = cartModel?.cartItems?.firstWhere(
            (i) => i.productId == newItem.productId,
            orElse: () => newItem,
          );
          return newItem.copyWith(
            product: oldItem?.product, // keep old product
            restaurant: oldItem?.restaurant, // keep old restaurant
          );
        }).toList();

        cartModel = success.copyWith(cartItems: updatedItems);
        emit(state.copyWith(cartState: CartLoaded(cartModel!)));
      },
    );
  }

  /// Decrement product quantity
  Future<void> decrementProduct(String productId) async {
    final currentItem = state.cartState is CartLoaded
        ? (state.cartState as CartLoaded)
            .cartModel
            .cartItems
            ?.firstWhere((item) => item.productId.toString() == productId)
        : null;

    if (currentItem != null && currentItem.qty > 1) {
      // emit(state.copyWith(cartState: CartDecrementLoading()));

      final result = await _repository.decrementProduct(
        cartModel!,
        productId,
        _loginBloc.userInformation!.token,
      );

      result.fold(
        (l) =>
            emit(state.copyWith(cartState: CartError(l.message, l.statusCode))),
        (success) {
          // preserve product details from the old cartModel
          final updatedItems = success.cartItems?.map((newItem) {
            final oldItem = cartModel?.cartItems?.firstWhere(
              (i) => i.productId == newItem.productId,
              orElse: () => newItem,
            );
            return newItem.copyWith(
              product: oldItem?.product, // keep old product
              restaurant: oldItem?.restaurant, // keep old restaurant
            );
          }).toList();

          cartModel = success.copyWith(cartItems: updatedItems);
          emit(state.copyWith(cartState: CartLoaded(cartModel!)));
        },
      );
    }
  }

  ///Clear Cart
  Future<void> clearCart() async {
    emit(state.copyWith(cartState: CartDeleteLoading()));
    final result =
        await _repository.clearCart(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(
          state.copyWith(cartState: CartDeleteError(l.message, l.statusCode))),
      (success) {
        cartModel = success;
        emit(state.copyWith(cartState: CartDeleteSuccess(success)));
      },
    );
  }
}
