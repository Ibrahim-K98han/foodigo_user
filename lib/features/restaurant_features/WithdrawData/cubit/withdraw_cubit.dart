import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/restaurant_login_bloc.dart';
import '../model/withdraw_model.dart';
import '../model/withdraw_store_state_model.dart';
import '../repository/withdraw_repository.dart';
import 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawStoreStateModel> {
  final WithdrawRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  WithdrawCubit({
    required WithdrawRepository repository,
    required RestaurantLoginBloc loginBloc,
  }) : _repository = repository,
       _loginBloc = loginBloc,
       super(const WithdrawStoreStateModel());

  WithdrawModel? withdrawModel;
  NewWithdrawResponse? newWithdrawResponse;

  void methodId(String id) => emit(state.copyWith(methodId: id));

  void amount(String amount) => emit(state.copyWith(amount: amount));

  void description(String description) =>
      emit(state.copyWith(bankDescription: description));

  /// Get Withdraw Data
  Future<void> getWithdraw() async {
    emit(state.copyWith(withdrawState: const WithdrawMethodLoading()));
    final result = await _repository.getWithdrawMethod(
      _loginBloc.userInformation!.token,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          withdrawState: WithdrawMethodError(
            failure.message,
            failure.statusCode,
          ),
        ),
      ),
      (success) {
        withdrawModel = success;
        emit(state.copyWith(withdrawState: WithdrawMethodLoaded(success)));
      },
    );
  }

  ///Store Withdraw
  Future<void> addNewWithdraw() async {
    emit(state.copyWith(withdrawState: const WithdrawMethodLoading()));
    final result = await _repository.addNewWithdraw(
      state,
      _loginBloc.userInformation!.token,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            withdrawState: WithdrawMethodError(
              failure.message,
              failure.statusCode,
            ),
          ),
        );
      },
      (success) {
        emit(state.copyWith(withdrawState: WithdrawStoreLoaded(success)));
        clear(); // reset form if needed
      },
    );
  }

  void clear() {
    emit(
      const WithdrawStoreStateModel(
        methodId: '',
        amount: '',
        bankDescription: '',
        withdrawState: WithdrawMethodInitial(),
      ),
    );
  }
}
