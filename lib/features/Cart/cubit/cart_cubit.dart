import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';
import '../repository/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit({required CartRepository repository})
      : _repository = repository,
        super(CartInitial());

  CartModel? cartModel;

  Future<void> getCartData() async {
    emit(CartLoading());
    final result = await _repository.getCartData();
    result.fold(
      (l) => emit(CartError(l.message, l.statusCode)),
      (success) {
        cartModel = success;
        emit(CartLoaded(success));
      },
    );
  }
}
