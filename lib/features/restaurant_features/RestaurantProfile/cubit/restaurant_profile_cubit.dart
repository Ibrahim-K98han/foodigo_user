import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/model/restaurant_profile_model.dart';
import '../../Login/bloc/restaurant_login_bloc.dart';
import '../model/restaurant_profile_state_model.dart';
import '../repository/restaurant_profile_repository.dart';
import 'restaurant_profile_state.dart';
import 'package:foodigo/utils/utils.dart';

class RestaurantProfileCubit extends Cubit<RestaurantProfileStateModel> {
  final RestaurantProfileRepository _repository;
  final RestaurantLoginBloc _loginBloc;

  RestaurantProfileCubit({
    required RestaurantProfileRepository repository,
    required RestaurantLoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const RestaurantProfileStateModel());

  RestaurantProfileModel? restaurantProfileModel;

  // ========= State Updaters =========
  void restaurantName(String restaurantName) =>
      emit(state.copyWith(restaurantName: restaurantName));

  void cityId(String cityId) => emit(state.copyWith(cityId: cityId));

  void cuisines(List<String> cuisines) =>
      emit(state.copyWith(cuisines: cuisines));

  void whatsapp(String whatsapp) =>
      emit(state.copyWith(whatsappNumber: whatsapp));

  void address(String address) => emit(state.copyWith(address: address));

  void latitude(String latitude) => emit(state.copyWith(latitude: latitude));

  void longitude(String longitude) =>
      emit(state.copyWith(longitude: longitude));

  void maxDeliveryDistance(String maxDeliveryDistance) =>
      emit(state.copyWith(maxDeliveryDistance: maxDeliveryDistance));

  void ownerName(String ownerName) =>
      emit(state.copyWith(ownerName: ownerName));

  void ownerEmail(String ownerEmail) =>
      emit(state.copyWith(ownerEmail: ownerEmail));

  void ownerPhone(String ownerPhone) =>
      emit(state.copyWith(ownerPhoneNumber: ownerPhone));

  void name(String name) => emit(state.copyWith(name: name));

  void openingHour(String openingHour) =>
      emit(state.copyWith(openingHours: openingHour));

  void closingHour(String closingHour) =>
      emit(state.copyWith(closingHours: closingHour));

  void minProcessingTime(String minProcessingTime) =>
      emit(state.copyWith(minProcessingTime: minProcessingTime));

  void maxProcessingTime(String maxProcessingTime) =>
      emit(state.copyWith(maxProcessingTime: maxProcessingTime));

  void timeSlot(String timeSlot) =>
      emit(state.copyWith(timeSlotSeparator: timeSlot));

  void logo(String logo) => emit(state.copyWith(logo: logo));

  void coverImage(String coverImage) =>
      emit(state.copyWith(images: coverImage));

  void isFeatured(bool isFeatured) =>
      emit(state.copyWith(isFeatured: isFeatured));

  void isPickup(bool isPickup) => emit(state.copyWith(isPickupOrder: isPickup));

  void isDelivery(bool isDelivery) =>
      emit(state.copyWith(isDeliveryOrder: isDelivery));

  void tags(String tags) => emit(state.copyWith(tags: tags));

  void slug(String slug) => emit(state.copyWith(slug: slug));

  // ========= Fetch Restaurant Profile =========
  Future<void> getRestaurantProfile() async {
    emit(state.copyWith(
        restaurantProfileState: const RestaurantProfileLoading()));

    final result = await _repository
        .getRestaurantProfile(_loginBloc.userInformation!.token);

    result.fold(
      (l) => emit(state.copyWith(
        restaurantProfileState: RestaurantProfileError(l.message, l.statusCode),
      )),
      (success) {
        restaurantProfileModel = success;

        final profile = restaurantProfileModel?.restaurantProfile;

        if (profile != null) {
          emit(state.copyWith(
            restaurantName: profile.restaurantName,
            cityId: profile.cityId,
            cuisines: _parseCuisines(restaurantProfileModel?.cuisines),
            whatsappNumber: profile.whatsapp,
            address: profile.address,
            latitude: profile.latitude,
            longitude: profile.longitude,
            maxDeliveryDistance: profile.maxDeliveryDistance,
            ownerName: profile.ownerName,
            ownerEmail: profile.ownerEmail,
            ownerPhoneNumber: profile.ownerPhone,
            name: profile.name,
            openingHours: profile.openingHour,
            closingHours: profile.closingHour,
            minProcessingTime: profile.minProcessingTime,
            maxProcessingTime: profile.maxProcessingTime,
            isFeatured: _parseBool(
                restaurantProfileModel!.restaurantProfile!.isFeatured),
            isDeliveryOrder: _parseBool(
                restaurantProfileModel!.restaurantProfile!.isDeliveryOrder),
            isPickupOrder: _parseBool(
                restaurantProfileModel!.restaurantProfile!.isPickupOrder),
            restaurantProfileState: RestaurantProfileLoaded(success),
          ));
        } else {
          emit(state.copyWith(
            restaurantProfileState: RestaurantProfileLoaded(success),
          ));
        }
      },
    );
  }

  ///Update Restaurant Profile
  Future<void> updateRestaurantProfile() async {
    emit(state.copyWith(
        restaurantProfileState: UpdateRestaurantProfileLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.updateRestaurantProfile,
      _loginBloc.userInformation!.token,
      _loginBloc.state.languageCode,
    );
    print('Update Restaurant Profile $uri');
    try {
      final result = await _repository.updateRestaurantProfile(
        state,
        uri,
        _loginBloc.userInformation!.token,
      );
      print('APi Call Success');
      result.fold((failure) {
        emit(state.copyWith(
            restaurantProfileState: UpdateRestaurantProfileError(
                failure.message, failure.statusCode)));
      }, (success) {
        restaurantProfileModel = success;
        emit(state.copyWith(
            restaurantProfileState: UpdateRestaurantProfileLoaded(success)));
      });
    } catch (e) {
      emit(state.copyWith(
        restaurantProfileState: UpdateRestaurantProfileError(e.toString(), 500),
      ));
    }
  }

  bool _parseBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      return value == "1" || value.toLowerCase() == "true";
    }
    return false;
  }

  List<String> _parseCuisines(dynamic raw) {
    if (raw == null) return [];
    try {
      if (raw is String) {
        return List<String>.from(jsonDecode(raw));
      } else if (raw is List) {
        return raw.map((e) => e.toString()).toList();
      }
    } catch (_) {}
    return [];
  }
}
