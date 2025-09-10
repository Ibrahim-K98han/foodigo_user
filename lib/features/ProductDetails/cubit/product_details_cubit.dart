import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';
import 'package:foodigo/features/ProductDetails/cubit/product_details_state.dart';
import 'package:foodigo/features/ProductDetails/repository/product_details_repository.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepository _repository;

  ProductDetailsCubit({required ProductDetailsRepository repository})
      : _repository = repository,
        super(ProductDetailsInitial());

  FeaturedProducts? featuredProducts;

  int? selectedAddonId; // <-- track selected addon

  // call this when user selects an addon
  void selectAddon(int addonId) {
    selectedAddonId = addonId;
    emit(ProductDetailsLoaded(featuredProducts!));
  }

  Future<void> getProductDetailsData(int id) async {
    emit(ProductDetailsLoading());

    final result = await _repository.getProductDetailsData(id);
    result.fold(
      (l) => emit(ProductDetailsError(l.message, l.statusCode)),
      (success) {
        featuredProducts = success;
        emit(ProductDetailsLoaded(success));
      },
    );
  }
}
