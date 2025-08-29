import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';
import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';
import '../repository/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;
  final LoginBloc _loginBloc;

  CartCubit({
    required CartRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(CartInitial());

  CartModel? cartModel;

  Future<void> getCartData() async {
    emit(CartLoading());
    // final result = await _repository.getCartData();
    final uri = Utils.tokenWithCode(
      RemoteUrls.getCartData,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Cart======$uri');
    final result = await _repository.getCartData(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(CartError(l.message, l.statusCode)),
      (success) {
        cartModel = success;
        emit(CartLoaded(success));
      },
    );
  }
}
