import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/checkout/cubit/checkout_state.dart';
import 'package:foodigo/features/checkout/model/checkout_response_model.dart';
import 'package:foodigo/features/checkout/model/checkout_state_model.dart';
import 'package:foodigo/features/checkout/repository/checkout_repository.dart';

import '../../../data/errors/failure.dart';
import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';

class CheckoutCubit extends Cubit<CheckoutStateModel> {
  final CheckoutRepository _repository;
  final LoginBloc _loginBloc;

  CheckoutCubit({
    required CheckoutRepository repository,
    required LoginBloc loginBloc,
  }) : _repository = repository,
       _loginBloc = loginBloc,
       super(const CheckoutStateModel());

  CheckoutResponseModel? checkoutResponseModel;

  // orderType
  void orderType(String type) {
    emit(state.copyWith(orderType: type));
  }

  void addressId(String type) {
    print("address id : $type");
    emit(state.copyWith(addressId: type));
  }

  // deliveryInstruction
  void deliveryInstruction(String deliveryInstruction) {
    emit(state.copyWith(deliveryInstructions: deliveryInstruction));
  }

  // couponCode
  void couponCode(String couponCode) {
    emit(state.copyWith(couponCode: couponCode));
  }

  // Add to cart
  Future<void> checkOut(String addressId) async {
    emit(
      state.copyWith(
        addressId: addressId,
        checkoutState: CheckoutStateLoading(),
      ),
    );
    log("cart body: ${state.toMap()}");

    final uri = Utils.tokenWithCode(
      RemoteUrls.checkOut,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );

    print('$uri');

    final result = await _repository.checkOut(
      state,
      _loginBloc.userInformation!.token,
    );

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(
            state.copyWith(
              checkoutState: CheckoutStateFormValidate(failure.errors),
            ),
          );
        } else {
          emit(
            state.copyWith(
              checkoutState: CheckoutStateError(
                failure.message,
                failure.statusCode,
              ),
            ),
          );
        }
      },
      (success) {
        checkoutResponseModel = success;
        emit(state.copyWith(checkoutState: CheckoutStateSuccess(success)));
      },
    );
  }

  //   Uri webPaymentInfo(String url) {
  //     // Build query parameters without token
  //     final queryParams = state
  //         .copyWith(
  //         token: _loginBloc.userInformation!.token)
  //         .toMap()
  //       ..remove('token'); // make sure token is not added as query param
  //
  //     final uri = Uri.parse(url).replace(queryParameters: queryParams);
  //     return uri;
  //   }
  //
  // // Then when calling API:
  //   Future<void> payWithStripe(String url) async {
  //     final uri = webPaymentInfo(url);
  //
  //     final response = await http.get(
  //       uri,
  //       headers: {
  //         'Authorization': 'Bearer ${_loginBloc.userInformation!.token}',
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //     );
  //
  //     print('Response: ${response.statusCode}');
  //     print('Body: ${response.body}');
  //   }

  Uri webPaymentInfo(String url) {
    final queryParams = state.toMap()..remove('token');
    return Uri.parse(url).replace(queryParameters: queryParams);
  }

  //
  // // If you just need the payment URL for WebView
  //   Future<Uri> payWithStripe(String url) async {
  //     final uri = webPaymentInfo(url);
  //     return uri;
  //   }
}
