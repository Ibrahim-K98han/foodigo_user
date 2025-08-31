import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/model/address_model.dart';
import 'package:foodigo/features/address/model/address_state_model.dart';
import '../../../data/errors/failure.dart';
import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';
import '../repository/get_address_repository.dart';
import 'get_address_state.dart';

class GetAddressCubit extends Cubit<AddressStateModel> {
  final GetAddressRepository _repository;
  final LoginBloc _loginBloc;

  GetAddressCubit({
    required GetAddressRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const AddressStateModel());

  List<Address> get getAddress => state.addressState is AllAddressLoaded
      ? (state.addressState as AllAddressLoaded).getAddress
      : [];

  Address? addr;

  void addressType(String type) {
    emit(state.copyWith(type: type));
  }

  void fullName(String name) {
    emit(state.copyWith(name: name));
  }

  void email(String email) {
    emit(state.copyWith(email: email));
  }

  void phone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void address(String address) {
    emit(state.copyWith(address: address));
  }

  void landMark(String landMark) {
    emit(state.copyWith(landmark: landMark));
  }

  void latitude(String latitude) {
    emit(state.copyWith(latitude: latitude));
  }

  void longitude(String longitude) {
    emit(state.copyWith(longitude: longitude));
  }

  void clearForm() {
    emit(const AddressStateModel());
  }

  Future<void> addAddress() async {
    // Ensure productId is in state
    emit(state.copyWith(addressState: AddAddressStateLoading()));
    log("cart body: ${state.toMap()}");

    final uri = Utils.tokenWithCode(
      RemoteUrls.addAddress,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('$uri');
    final result =
        await _repository.addAddress(state, _loginBloc.userInformation!.token);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
              addressState: AddAddressStateFormValidate(failure.errors)));
        } else {
          emit(state.copyWith(
              addressState:
                  AddAddresstStateError(failure.message, failure.statusCode)));
        }
      },
      (success) {
        addr = success;
        emit(state.copyWith(addressState: AddAddressStateSuccess(success)));
      },
    );
  }

  Future<void> getAllAddressData() async {
    emit(state.copyWith(addressState: AllAddressLoading()));

    final result = await _repository
        .getAllRestaurantData(_loginBloc.userInformation!.token);

    result.fold(
      (l) => emit(state.copyWith(
          addressState: AAllAddressError(l.message, l.statusCode))),
      (success) {
        emit(state.copyWith(addressState: AllAddressLoaded(success)));
      },
    );
  }

  Future<void> deleteAddress(String id) async {
    emit(state.copyWith(addressState: DeleteAddressLoading(id)));

    final result =
        await _repository.deleteAddress(_loginBloc.userInformation!.token, id);

    result.fold(
      (l) => emit(state.copyWith(
          addressState: DeleteAddressError(l.message, l.statusCode))),
      (success) {
        final updated = getAddress.where((e) => e.id.toString() != id).toList();
        emit(state.copyWith(addressState: AllAddressLoaded(updated)));
      },
    );
  }
}
