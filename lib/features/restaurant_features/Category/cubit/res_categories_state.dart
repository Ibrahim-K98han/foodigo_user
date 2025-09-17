import 'package:equatable/equatable.dart';
import '../model/res_category_model.dart';

abstract class ResCategoriesState extends Equatable {
  const ResCategoriesState();

  @override
  List<Object?> get props => [];
}

/// Initial
class ResCategoriesInitial extends ResCategoriesState {
  const ResCategoriesInitial();
}

/// Loading
class ResCategoriesLoading extends ResCategoriesState {
  const ResCategoriesLoading();
}

/// Loaded
class ResCategoriesLoaded extends ResCategoriesState {
  final ResCategoryModel categoryModel;

  const ResCategoriesLoaded(this.categoryModel);

  @override
  List<Object?> get props => [categoryModel];
}

/// Success
class ResCategoriesSuccess extends ResCategoriesState {
  final String message;

  const ResCategoriesSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error
class ResCategoriesError extends ResCategoriesState {
  final String message;
  final int statusCode;

  const ResCategoriesError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
