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
  }) : _repository = repository,
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

  void sizePrice(List<String> prices) => emit(state.copyWith(price: prices));

  void description(String text) {
    emit(state.copyWith(shortDescription: text));
  }

  void specification(List<String> specification) =>
      emit(state.copyWith(specification: specification));

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
          storeProductResponseModel = success;
          emit(state.copyWith(storeProductState: StoreProductLoaded(success)));
          clear();
        },
      );
    } catch (e) {
      emit(
        state.copyWith(storeProductState: StoreProductError(e.toString(), 500)),
      );
    }
  }

  /// ----------------- Update Store Product -----------------
  Future<void> updateProduct(String productId) async {
    emit(state.copyWith(storeProductState: StoreProductUpdateLoading()));

    final uri = Utils.tokenWithCode(
      RemoteUrls.updateStoreProduct(productId),
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );

    print('Update product URL: $uri');

    try {
      // 🔹 Convert variation list to JSON object
      final convertedVariations = convertVariationsToObject();
      // 🔹 Convert specification list to JSON array
      final specList = jsonEncode(state.specification);

      // 🔹 Make a copy of the state with proper string formats
      final updatedState = state.copyWith(
        size: [convertedVariations], // send as JSON string
        specification: [specList],
      );

      final result = await _repository.updateStoreProduct(
        state,
        uri,
        _loginBloc.userInformation!.token,
      );

      print('✅ Update API called successfully');

      result.fold(
        (failure) {
          print('❌ Update failed: ${failure.message}');
          emit(
            state.copyWith(
              storeProductState: StoreProductUpdateError(
                failure.message,
                failure.statusCode,
              ),
            ),
          );
        },
        (success) {
          storeProductResponseModel = success;
          print('✅ Update successful: $success');

          emit(
            state.copyWith(
              storeProductState: StoreProductUpdateLoaded(success),
            ),
          );
        },
      );
    } catch (e) {
      // print('❌ Exception during update: $e');
      emit(
        state.copyWith(
          storeProductState: StoreProductUpdateError(e.toString(), 500),
        ),
      );
    }
  }


  /// 🔥 Helper: Convert size & price arrays to object format
  /// Input: size: ["small","medium"], price: ["30","40"]
  /// Output: {"small":"30","medium":"40"}
  String convertVariationsToObject() {
    if (state.size.isEmpty || state.price.isEmpty) return '{}';

    final Map<String, String> variationMap = {};

    // Ensure both arrays have same length
    final length =
        state.size.length < state.price.length
            ? state.size.length
            : state.price.length;

    for (int i = 0; i < length; i++) {
      if (state.size[i].isNotEmpty) {
        variationMap[state.size[i]] = state.price[i];
      }
    }

    final result = jsonEncode(variationMap);
    print('🔄 Converted variations to object: $result');
    return result;
  }

  /// ----------------- Get Product By ID -----------------
  Future<void> getEditProduct(String id) async {
    emit(state.copyWith(storeProductState: EditProductLoading()));
    final url = Utils.tokenWithCode(
      RemoteUrls.editProduct(id),
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Get Product $url');

    final result = await _repository.getEditProduct(
      url,
      _loginBloc.userInformation!.token,
    );
    result.fold(
      (failure) {
        final errorState = EditProductError(
          failure.message,
          failure.statusCode,
        );
        emit(state.copyWith(storeProductState: errorState));
      },
      (success) {
        products = success;
        if (products != null) {
          print('🔍 ProductTranslate Size: ${products!.product!.size}');
          print('🔍 Product Price: ${products!.product!.price}');

          // ✅ Parse করি - size field এ পুরো object আছে
          final parsedSizes = _parseSize(products!.product!.size);

          // 🔥 Same field থেকে prices extract করি (যেহেতু size field এই {"name":"price"} format এ আছে)
          final parsedPrices = _extractPricesFromSizeField(
            products!.product!.size,
          );

          print('✅ Parsed Sizes: $parsedSizes');
          print('✅ Parsed Prices: $parsedPrices');

          emit(
            state.copyWith(
              name: products!.productTranslate!.name,
              slug: products!.product!.slug,
              categoryId: products!.product!.categoryId.toString(),
              // addonItems: _parseAddonItems(products!.product!.addonItems),
              addonItems:
                  products!.product!.addons?.map((a) => a.id.toString()).toList() ?? [],
              image: products!.product!.image,
              productPrice: products!.product!.price.toString(),
              offerPrice: products!.product!.offerPrice.toString(),
              size: parsedSizes,
              price: parsedPrices,
              translateId: products!.productTranslate!.id.toString(),
              specification: _parseSpecification(
                products!.productTranslate!.specification,
              ),
              shortDescription: products!.productTranslate!.shortDescription,
            ),
          );
        }
        final successState = EditProductLoaded(success);
        emit(state.copyWith(storeProductState: successState));
      },
    );
  }

  /// ----------------- Delete Store Product -----------------
  Future<void> deleteStoreProduct(String productId) async {
    emit(state.copyWith(storeProductState: DeleteStoreProductLoading()));
    final result = await _repository.deleteStoreProduct(
      _loginBloc.userInformation!.token,
      productId,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          storeProductState: DeleteStoreProError(l.message, l.statusCode),
        ),
      ),
      (success) =>
          emit(state.copyWith(storeProductState: CartDeleteSuccess(success))),
    );
  }

  List<String> _parseAddonItems(dynamic addonItems) {
    print(
      '🔍 _parseAddonItems - Input: $addonItems (Type: ${addonItems.runtimeType})',
    );

    if (addonItems == null) return [];

    try {
      // যদি এটা List হয়
      if (addonItems is List) {
        // যদি List এর মধ্যে objects থাকে (যেমন: [{id: 1, name: "Extra Cheese"}, ...])
        if (addonItems.isNotEmpty && addonItems.first is Map) {
          final result =
              addonItems
                  .map((addon) => addon['id']?.toString() ?? '')
                  .where((id) => id.isNotEmpty)
                  .toList();
          print('✅ Parsed addon IDs from list of objects: $result');
          return result;
        }
        // যদি শুধু IDs এর list থাকে (যেমন: [1, 2, 3])
        else {
          final result = addonItems.map((id) => id.toString()).toList();
          print('✅ Parsed addon IDs from simple list: $result');
          return result;
        }
      }
      // যদি এটা String হয় (JSON format এ)
      else if (addonItems is String) {
        final decoded = jsonDecode(addonItems);
        return _parseAddonItems(decoded); // Recursively parse করি
      }
    } catch (e) {
      print('❌ Error in _parseAddonItems: $e');
    }

    return [];
  }

  /// ✅ Parse size from JSON object like {"small":"30","medium":"40","large":"50"}
  /// Returns the keys as variation names
  List<String> _parseSize(dynamic raw) {
    print('🔍 _parseSize - Input: $raw (Type: ${raw.runtimeType})');

    if (raw == null || raw == '') return [];

    try {
      if (raw is String) {
        final decoded = jsonDecode(raw);
        print('📦 Decoded: $decoded');

        // ✅ যদি এটা একটা Map/Object হয়
        if (decoded is Map) {
          final result = decoded.keys.map((e) => e.toString()).toList();
          print('✅ Final sizes (keys): $result');
          return result;
        }
        // যদি array হয়
        else if (decoded is List) {
          final result = List<String>.from(decoded);
          print('✅ Final sizes (array): $result');
          return result;
        }
      } else if (raw is Map) {
        return raw.keys.map((e) => e.toString()).toList();
      } else if (raw is List) {
        return raw.map((e) => e.toString()).toList();
      }
    } catch (e) {
      print('❌ Error in _parseSize: $e');
    }
    return [];
  }

  /// ✅ Parse variation prices from the same JSON object
  /// Returns the values as prices
  List<String> _parseSizePrice(dynamic raw) {
    print('🔍 _parseSizePrice - Input: $raw (Type: ${raw.runtimeType})');

    // 🔥 এখন আমরা ProductTranslate.size থেকে prices extract করব
    // কারণ API response এ size field এ পুরো object আছে
    if (raw == null || raw == '') {
      // যদি price field খালি থাকে, তাহলে size field check করি
      if (products?.productTranslate?.size != null) {
        return _extractPricesFromSizeField(products!.productTranslate!.size);
      }
      return [];
    }

    try {
      if (raw is String) {
        final decoded = jsonDecode(raw);
        print('📦 Decoded: $decoded');

        // ✅ যদি এটা একটা Map/Object হয়
        if (decoded is Map) {
          final result = decoded.values.map((e) => e.toString()).toList();
          print('✅ Final prices (values): $result');
          return result;
        }
        // যদি array হয়
        else if (decoded is List) {
          final result = List<String>.from(decoded);
          print('✅ Final prices (array): $result');
          return result;
        }
      } else if (raw is Map) {
        return raw.values.map((e) => e.toString()).toList();
      } else if (raw is List) {
        return raw.map((e) => e.toString()).toList();
      }
    } catch (e) {
      print('❌ Error in _parseSizePrice: $e');
    }
    return [];
  }

  /// 🔥 Helper: size field থেকে prices extract করি
  /// If sizeName is provided, returns price for that size, else returns all prices as list
  List<String> _extractPricesFromSizeField(dynamic raw, {String? sizeName}) {
    print('🔍 _extractPricesFromSizeField - Input: $raw, sizeName: $sizeName');

    if (raw == null || raw == '') return [];

    try {
      if (raw is String) {
        final decoded = jsonDecode(raw);
        if (decoded is Map) {
          if (sizeName != null && decoded.containsKey(sizeName)) {
            // Return only the price for the specific size as a single-item list
            final price = decoded[sizeName].toString();
            print('✅ Extracted price for $sizeName: $price');
            return [price];
          }
          // Return all prices as before
          final result = decoded.values.map((e) => e.toString()).toList();
          print('✅ Extracted prices from size field: $result');
          return result;
        }
      } else if (raw is Map) {
        if (sizeName != null && raw.containsKey(sizeName)) {
          final price = raw[sizeName].toString();
          print('✅ Extracted price for $sizeName: $price');
          return [price];
        }
        return raw.values.map((e) => e.toString()).toList();
      }
    } catch (e) {
      print('❌ Error extracting prices: $e');
    }
    return [];
  }

  /// ✅ Parse specifications
  List<String> _parseSpecification(dynamic raw) {
    if (raw == null || raw == '') return [];

    try {
      if (raw is String) {
        final cleaned = raw.replaceAll(r'\"', '"');
        final decoded = jsonDecode(cleaned);
        if (decoded is List) {
          return List<String>.from(decoded);
        }
      } else if (raw is List) {
        return raw.map((e) => e.toString()).toList();
      }
    } catch (e) {
      print('❌ Error parsing specification: $e');
    }
    return [];
  }

  /// ----------------- Reset Form State -----------------
  void clear() {
    emit(
      const StoreProductStateModel(
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
      ),
    );
  }
}
