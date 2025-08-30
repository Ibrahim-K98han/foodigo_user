import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/model/address_model.dart';

import '../../../data/remote_url.dart';
import '../../../utils/utils.dart';
import '../../Login/bloc/login_bloc.dart';
import '../repository/get_address_repository.dart';
import 'get_address_state.dart';

class GetAddressCubit extends Cubit<AllAddressState> {
  final GetAddressRepository _repository;
  final LoginBloc _loginBloc;

  GetAddressCubit({
    required GetAddressRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(AllAddressInitial());

  List<Address> getAddress = [];

  Future<void> getAllAddressData() async {
    emit(AllAddressLoading());

    final uri = Utils.tokenWithCode(
      RemoteUrls.getAddress,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );

    print('Address $uri');
    final result = await _repository
        .getAllRestaurantData(_loginBloc.userInformation!.token);
    result.fold(
      (l) => emit(AAllAddressError(l.message, l.statusCode)),
      (success) {
        getAddress = success;
        emit(AllAddressLoaded(success));
      },
    );
  }

  // Delete address by ID
  Future<void> deleteAddress(String id) async {
    emit(AllAddressLoading());

    final result =
        await _repository.deleteAddress(_loginBloc.userInformation!.token, id);

    result.fold(
      (l) {
        emit(AAllAddressError(l.message, l.statusCode));
      },
      (success) {
        // Remove deleted address from local list
        getAddress.removeWhere((element) => element.id == id);
        emit(AllAddressLoaded(List.from(getAddress)));
      },
    );
  }
}
