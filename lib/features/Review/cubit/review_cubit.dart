import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/Review/model/review_model.dart';

import '../repository/review_repository.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepository _repository;
  final LoginBloc _loginBloc;

  ReviewCubit({
    required ReviewRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ReviewInitial());

  ReviewModel? reviewModel;

  ///Show Review
  Future<void> getReview() async {
    emit(const ReviewLoading());

    final result =
        await _repository.getReview(_loginBloc.userInformation!.token);

    result.fold(
      (l) => emit(ReviewError(l.message, l.statusCode)),
      (success) {
        reviewModel = success;
        emit(ReviewLoaded(success));
      },
    );
  }

  /// Add Review
// Future<void> addToWishList(int productId) async {
//   emit(const WishListLoading());
//
//   final result = await _repository.addToWishList(
//       _loginBloc.userInformation!.token, productId);
//
//   result.fold(
//     (l) => emit(WishListError(l.message, l.statusCode)),
//     (success) {
//       wishListModel = success;
//       emit(WishListSuccess(success));
//     },
//   );
// }
}
