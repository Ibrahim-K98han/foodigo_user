import 'dart:convert';
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

  void addon(String addon) => emit(state.copyWith(addonId: addon));

  void image(String image) => emit(state.copyWith(image: image));

  void productPrice(String price) => emit(state.copyWith(productPrice: price));

  void offerPrice(String offerPrice) =>
      emit(state.copyWith(offerPrice: offerPrice));

  void translateId(String translateId) {
    emit(state.copyWith(translateId: translateId));
  }

  void size(List<String> sizes) => emit(state.copyWith(size: sizes));

  void sizePrice(List<String> prices) => emit(state.copyWith(price: prices));

  void description(String text) => emit(state.copyWith(shortDescription: text));

  /// ----------------- Store Product API -----------------
  Future<void> storeProduct() async {
    emit(state.copyWith(storeProductState: StoreProductLoading()));
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
          storeProductResponseModel = success;
          emit(
            state.copyWith(
              storeProductState: StoreProductLoaded(success),
            ),
          );
          // clear();
        },
      );
    } catch (e) {
      emit(state.copyWith(
        storeProductState: StoreProductError(e.toString(), 500),
      ));
    }
  }

  /// ----------------- Get Product By ID -----------------
  Future<void> getEditProduct(String id) async {
    emit(state.copyWith(storeProductState: StoreProductLoading()));
    // final url = RemoteUrls.editProduct(id);
    final url = Utils.tokenWithCode(RemoteUrls.editProduct(id),
        _loginBloc.userInformation!.token, _loginBloc.state.languageCode);
    print('Get Product $url');

    final result = await _repository.getEditProduct(
      _loginBloc.userInformation!.token,
      id,
      url,
    );
    result.fold((failure) {
      final errorState = StoreProductError(failure.message, failure.statusCode);
      emit(state.copyWith(storeProductState: errorState));
    }, (success) {
      storeProductResponseModel = success;
      if (storeProductResponseModel != null) {
        emit(state.copyWith(
            name: storeProductResponseModel!.name,
            slug: storeProductResponseModel!.slug,
            categoryId: storeProductResponseModel!.categoryId,
            image: storeProductResponseModel!.image,
            productPrice: storeProductResponseModel!.price,
            offerPrice: storeProductResponseModel!.offerPrice.toString(),
            size: storeProductResponseModel!.size['size'] != null
                ? List<String>.from(storeProductResponseModel!.size['size'])
                : [],
            price: storeProductResponseModel!.size['price'] != null
                ? List<String>.from(storeProductResponseModel!.size['price'])
                : [],
            shortDescription: storeProductResponseModel!.shortDescription ?? '',
            translateId:
                storeProductResponseModel!.productTranslate?.id.toString() ??
                    '',
            storeProductState: StoreProductLoaded(success)));
      }
      final successState = StoreProductLoaded(success);
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

  /// ----------------- Update Store Product -----------------
  // Future<void> updateProduct(String productId) async {
  //   emit(state.copyWith(storeProductState: StoreProductUpdateLoading()));
  //   final uri = Utils.tokenWithCode(
  //     RemoteUrls.updateStoreProduct(productId),
  //     _loginBloc.userInformation!.token,
  //     _loginBloc.state.languageCode,
  //   );
  //   print('Update product url: $uri');
  //   print('Update Product Fields => ${state.toMap()}');
  //   try {
  //     final result = await _repository.updateStoreProduct(
  //       state,
  //       uri,
  //       _loginBloc.userInformation!.token,
  //     );
  //     print('API called successfully');
  //     result.fold(
  //       (failure) {
  //         emit(state.copyWith(
  //           storeProductState: StoreProductUpdateError(
  //             failure.message,
  //             failure.statusCode,
  //           ),
  //         ));
  //       },
  //       (success) {
  //         storeProductResponseModel = success;
  //         emit(
  //           state.copyWith(
  //               storeProductState: StoreProductUpdateLoaded(success),
  //               translateId: state.translateId),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(
  //       storeProductState: StoreProductUpdateError(e.toString(), 500),
  //     ));
  //   }
  // }

  Future<void> updateProduct(String productId) async {
    emit(state.copyWith(storeProductState: StoreProductUpdateLoading()));

    final uri = Utils.tokenWithCode(
      RemoteUrls.updateStoreProduct(productId),
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Update product url: $uri');

    try {
      // state থেকে Map বানান
      final body = state.toMap();

      // translate_id must, ফাঁকা হলেও পাঠান
      body['translate_id'] = state.translateId.isNotEmpty ? state.translateId : '0';

      // size & price JSON encode করুন
      body['size'] = jsonEncode(state.size);
      body['price'] = jsonEncode(state.price);

      print('Final Body Sent: $body');

      final result = await _repository.updateStoreProduct(
        state,
        uri,
        _loginBloc.userInformation!.token,
      );

      print('API called successfully');

      result.fold(
            (failure) {
          emit(state.copyWith(
            storeProductState: StoreProductUpdateError(
              failure.message,
              failure.statusCode,
            ),
          ));
        },
            (success) {
          storeProductResponseModel = success;
          emit(
            state.copyWith(
              storeProductState: StoreProductUpdateLoaded(success),
              translateId: state.translateId, // state ঠিক রেখে
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(
        storeProductState: StoreProductUpdateError(e.toString(), 500),
      ));
    }
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
