import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/Products/model/product_model.dart';

import '../../Login/bloc/restaurant_login_bloc.dart';
import '../repository/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  ProductCubit({
    required ProductRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ProductInitial());

  ProductModel? productModel;

  ///Get Product
  Future<void> getProduct() async {
    emit(const ProductLoading());
    final result =
        await _repository.getProduct(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(ProductError(l.message, l.statusCode)),
      (success) {
        productModel = success;
        emit(ProductLoaded(success));
      },
    );
  }

  /// Filter Products by categoryId
  List<ProductList> filterByCategory(String categoryId) {
    if (productModel == null) return [];
    return productModel!.productList!
        .where((p) => p.categoryId.toString() == categoryId.toString())
        .toList();
  }
}
