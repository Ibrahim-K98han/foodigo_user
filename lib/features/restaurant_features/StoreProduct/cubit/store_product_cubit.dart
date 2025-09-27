import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/Login/bloc/restaurant_login_bloc.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_state.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/edit_product_model.dart';
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
  ProductData? products;

  /// ----------------- Form Updaters -----------------
  void productName(String name) => emit(state.copyWith(name: name));

  void productSlug(String slug) => emit(state.copyWith(slug: slug));

  void category(String category) => emit(state.copyWith(categoryId: category));

  void addon(List<String> addon) => emit(state.copyWith(addonItems: addon));

  void image(String image) => emit(state.copyWith(image: image));

  void productPrice(String price) => emit(state.copyWith(productPrice: price));

  void offerPrice(String offerPrice) =>
      emit(state.copyWith(offerPrice: offerPrice));

  void translateId(String translateId) =>
      emit(state.copyWith(translateId: translateId));

  void size(List<String> sizes) => emit(state.copyWith(size: sizes));

  void specification(List<String> specification) =>
      emit(state.copyWith(specification: specification));

  void sizePrice(List<String> prices) => emit(state.copyWith(price: prices));

  void description(String text) => emit(state.copyWith(shortDescription: text));

  /// ----------------- Store Product API -----------------
  Future<void> storeProduct() async {
    emit(state.copyWith(storeProductState: const StoreProductLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.storeProduct,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Store Product URI: $uri');
    try {
      final result = await _repository.storeProduct(
        state,
        uri,
        _loginBloc.userInformation!.token,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              storeProductState: StoreProductError(
                failure.message,
                failure.statusCode,
              ),
            ),
          );
        },
        (success) {
          products = success;
          emit(
            state.copyWith(
              storeProductState: StoreProductLoaded(success),
            ),
          );
          clear();
        },
      );
    } catch (e) {
      emit(state.copyWith(
        storeProductState: StoreProductError(e.toString(), 500),
      ));
    }
  }

  /// ----------------- Update Store Product -----------------
  Future<void> updateProduct(String productId) async {
    emit(state.copyWith(storeProductState: const StoreProductLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.updateStoreProduct(productId),
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Update product url: $uri');
    try {
      final result = await _repository.updateStoreProduct(
        state,
        uri,
        _loginBloc.userInformation!.token,
      );
      print('API called successfully');
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              storeProductState: StoreProductError(
                failure.message,
                failure.statusCode,
              ),
            ),
          );
        },
        (success) {
          final errors = StoreProductSuccess(success.toString());
          emit(
            state.copyWith(storeProductState: errors),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(
        storeProductState: EditProductError(e.toString(), 500),
      ));
    }
  }

  /// ----------------- Get Product By ID -----------------
  Future<void> getEditProduct(String id) async {
    emit(state.copyWith(storeProductState: EditProductLoading()));
    final url = Utils.tokenWithCode(RemoteUrls.editProduct(id),
        _loginBloc.userInformation!.token, _loginBloc.state.languageCode);
    print('Get Product $url');

    final result = await _repository.getEditProduct(
      url,
      _loginBloc.userInformation!.token,
    );
    result.fold((failure) {
      final errorState = EditProductError(failure.message, failure.statusCode);
      emit(state.copyWith(storeProductState: errorState));
    }, (success) {
      products = success;
      if (products != null) {
        emit(state.copyWith(
          name: products!.product!.name,
          slug: products!.product!.slug,
          categoryId: products!.product!.categoryId.toString(),
          image: products!.product!.image,
          productPrice: products!.product!.price.toString(),
          offerPrice: products!.product!.offerPrice.toString(),
          size: _parseSize(products!.product!.size),
          price: _parseSizePrice(products!.product!.price),
          shortDescription: products!.product!.shortDescription.toString(),
        ));
      }
      final successState = EditProductLoaded(success);
      emit(state.copyWith(storeProductState: successState));
    });
  }

  /// ----------------- Delete Store Product -----------------
  Future<void> deleteStoreProduct(String productId) async {
    emit(state.copyWith(storeProductState: DeleteStoreProductLoading()));
    final result = await _repository.deleteStoreProduct(
        _loginBloc.userInformation!.token, productId);
    result.fold(
      (l) => emit(state.copyWith(
          storeProductState: DeleteStoreProError(l.message, l.statusCode))),
      (success) =>
          emit(state.copyWith(storeProductState: CartDeleteSuccess(success))),
    );
  }

  List<String> _parseSize(dynamic raw) {
    if (raw == null) return [];
    try {
      if (raw is String) {
        return List<String>.from(jsonDecode(raw));
      } else if (raw is List) {
        return raw.map((e) => e.toString()).toList();
      }
    } catch (_) {}
    return [];
  }

  List<String> _parseSizePrice(dynamic raw) {
    if (raw == null) return [];
    try {
      if (raw is String) {
        return List<String>.from(jsonDecode(raw));
      } else if (raw is List) {
        return raw.map((e) => e.toString()).toList();
      }
    } catch (_) {}
    return [];
  }

  /// ----------------- Reset Form State -----------------
  void clear() {
    emit(const StoreProductStateModel(
      name: '',
      slug: '',
      categoryId: '',
      image: '',
      productPrice: '',
      offerPrice: '',
      size: [],
      price: [],
      shortDescription: '',
      storeProductState: StoreProductInitial(),
    ));
  }
}
