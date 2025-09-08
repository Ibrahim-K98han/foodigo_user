import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/features/PaymentMethod/model/payment_method_response_model.dart';
import 'package:foodigo/features/Subscription/cubit/subscription_state.dart';
import 'package:foodigo/features/Subscription/model/bank_payment_response_model.dart';
import 'package:foodigo/features/Subscription/repository/subscription_repository.dart';

import '../../../data/errors/failure.dart';
import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../model/bank_payment_request_model.dart';

class SubscriptionCubit extends Cubit<SubscriptionListState> {
  final SubscriptionRepository _repository;
  final LoginBloc _loginBloc;

  SubscriptionCubit({
    required SubscriptionRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const SubscriptionListInitial());

  Future<void> payWithBank({
    required String transactionInfo,
    required int addressId,
    required String orderType,
  }) async {
    emit(const BankPaymentStateLoading());

    final body = BankPaymentRequestModel(
      transactionInfo: transactionInfo,
      orderData: OrderDataRequest(
        addressId: addressId,
        orderType: orderType,
      ),
    );

    final result =
        await _repository.payWithBank(body, _loginBloc.userInformation!.token);

    result.fold(
      (failure) {
        emit(BankPaymentStateError(failure.message, 500));
      },
      (success) {
        emit(BankPaymentStateLoaded(success.message));
      },
    );
  }
}
