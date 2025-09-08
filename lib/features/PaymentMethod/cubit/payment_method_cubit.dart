import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:foodigo/features/PaymentMethod/cubit/payment_method_state.dart';
import '../../../data/errors/failure.dart';
import '../../Login/bloc/login_bloc.dart';
import '../model/payment_method_response_model.dart';
import '../repository/payment_method_repository.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentMethodRepository _repository;
  final LoginBloc _loginBloc;

  PaymentCubit({
    required PaymentMethodRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const PaymentInitial());

  PaymentMethodModel? paymentMethodModel;

  Future<void> fetchPaymentMethods() async {
    emit(const PaymentLoading());
    final Either<Failure, PaymentMethodModel> result =
        await _repository.getPaymentMethod(_loginBloc.userInformation!.token);

    result.fold(
      (failure) => emit(PaymentError(failure.message, failure.statusCode)),
      (methods) {
        paymentMethodModel = methods;
        emit(PaymentLoaded(methods));
      },
    );
  }
}
