import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import '../model/payment_method_response_model.dart';
import '../repository/payment_method_repository.dart';
import 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  final PaymentMethodRepository _repository;
  final LoginBloc _loginBloc;

  PaymentMethodCubit({
    required PaymentMethodRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const PaymentMethodStateInitial());

  PaymentMethodResponseModel? paymentMethodResponseModel;

  Future<void> getAllPaymentMethodData() async {
    emit(PaymentMethodStateLoading());

    final result =
        await _repository.getPaymentMethod(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(PaymentMethodStateError(l.message, l.statusCode)),
      (success) {
        paymentMethodResponseModel = success;
        emit(PaymentMethodStateLoaded(success));
      },
    );
  }
}
