import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Review/model/review_model.dart';

import '../model/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();

  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  const ProductLoading();

  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final ProductModel productModel;

  const ProductLoaded(this.productModel);

  @override
  List<Object?> get props => [productModel];
}

class ProductSuccess extends ProductState {
  final ProductModel productModel;

  const ProductSuccess(this.productModel);

  @override
  List<Object?> get props => [productModel];
}

class ProductError extends ProductState {
  final String message;
  final int statusCode;

  const ProductError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
