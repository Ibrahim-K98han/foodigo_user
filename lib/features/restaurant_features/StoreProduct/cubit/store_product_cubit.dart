import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/Login/bloc/restaurant_login_bloc.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_state.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_response_model.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/repository/store_product_repository.dart';
import 'package:foodigo/utils/utils.dart';

class StoreProductCubit extends Cubit<StoreProductStateModel> {
  final StoreProductRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  StoreProductCubit({
    required StoreProductRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const StoreProductStateModel());

  StoreProductResponseModel? storeProductResponseModel;

  /// ----------------- Form Updaters -----------------
  void productName(String name) => emit(state.copyWith(name: name));

  void productSlug(String slug) => emit(state.copyWith(slug: slug));

  void category(String category) => emit(state.copyWith(categoryId: category));

  void image(String image) => emit(state.copyWith(image: image));

  void productPrice(String price) => emit(state.copyWith(productPrice: price));

  void size(List<String> size) => emit(state.copyWith(size: size));

  void sizePrice(List<String> sizePrice) =>
      emit(state.copyWith(price: sizePrice));

  void description(String text) => emit(state.copyWith(shortDescription: text));

  /// ----------------- Store Product API -----------------
  Future<void> storeProduct() async {
    emit(state.copyWith(storeProductState: StoreProductLoading()));

    final uri = Utils.tokenWithCode(
      RemoteUrls.storeProduct,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Store Product API: $uri');

    try {
      final result = await _repository.storeProduct(
        state,
        uri,
        _loginBloc.userInformation!.token,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            storeProductState: StoreProductError(
              failure.message,
              failure.statusCode,
            ),
          ));
        },
        (success) {
          storeProductResponseModel = success;
          emit(state.copyWith(
            storeProductState: StoreProductLoaded(success),
          ));
          clear();
        },
      );
    } catch (e) {
      emit(state.copyWith(
        storeProductState: StoreProductError(e.toString(), 500),
      ));
    }
  }

  /// ----------------- Reset State -----------------
  void clear() {
    emit(const StoreProductStateModel(
      name: '',
      slug: '',
      categoryId: '',
      image: '',
      productPrice: '',
      size: [],
      price: [],
      shortDescription: '',
      storeProductState: StoreProductInitial(),
    ));
  }
}
