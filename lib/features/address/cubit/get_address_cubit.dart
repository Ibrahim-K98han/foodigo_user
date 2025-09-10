import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/model/address_model.dart';
import 'package:foodigo/features/address/model/address_state_model.dart';
import '../../../data/errors/failure.dart';
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

  /// Add address
  Future<void> addAddress() async {
    emit(state.copyWith(addressState: AddAddressStateLoading()));
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
                AddAddresstStateError(failure.message, failure.statusCode),
          ));
        }
      },
      (success) {
        addr = success;
        // reload all addresses after success
        getAllAddressData();
      },
    );
  }

  ///Show Address
  Future<void> getAllAddressData() async {
    emit(state.copyWith(addressState: AllAddressLoading()));

    final result =
        await _repository.getAllAddressData(_loginBloc.userInformation!.token);

    result.fold(
      (l) => emit(state.copyWith(
          addressState: AAllAddressError(l.message, l.statusCode))),
      (success) {
        emit(state.copyWith(addressState: AllAddressLoaded(success)));
      },
    );
  }

  /// Delete address
  Future<void> deleteAddress(String id) async {
    emit(state.copyWith(addressState: DeleteAddressLoading(id)));

    final result =
        await _repository.deleteAddress(_loginBloc.userInformation!.token, id);

    result.fold(
      (l) => emit(state.copyWith(
        addressState: DeleteAddressError(l.message, l.statusCode),
      )),
      (success) async {
        // reload all addresses after delete
        await getAllAddressData();
      },
    );
  }

  /// Update address
  Future<void> updateAddress(String id) async {
    emit(state.copyWith(addressState: UpdateAddressLoading(id)));
    log("update address body: ${state.toMap()}");

    final result = await _repository.updateAddress(
        state, _loginBloc.userInformation!.token, id);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
              addressState: UpdateAddressFormValidate(failure.errors)));
        } else {
          emit(state.copyWith(
              addressState:
                  UpdateAddressError(failure.message, failure.statusCode)));
        }
      },
      (success) async{
        addr = success;
        emit(state.copyWith(addressState: UpdateAddressSuccess(success)));
        await getAllAddressData();
      },
    );
  }
}
