import 'package:foodigo/features/Login/model/user_response_model.dart';
import 'package:foodigo/features/restaurant_features/Login/model/restaurant_login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/k_strings.dart';
import 'errors/exception.dart';

abstract class LocalDataSources {
  bool checkOnBoarding();

  Future<bool> cachedOnBoarding();

  Future<bool> cacheUserResponse(UserResponseModel userResponseModel);

  Future<bool> cacheRestaurantResponse(
      RestaurantLoginResponse restaurantLoginResponse);

  UserResponseModel getExistingUserInfo();

  RestaurantLoginResponse getExistingRestaurantInfo();

  Future<bool> clearUserResponse();
}

class LocalDataSourcesImpl implements LocalDataSources {
  final SharedPreferences sharedPreferences;

  LocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<bool> cachedOnBoarding() async {
    return sharedPreferences.setBool(KStrings.cachedOnBoardingKey, true);
  }

  @override
  bool checkOnBoarding() {
    final jsonString = sharedPreferences.getBool(KStrings.cachedOnBoardingKey);
    if (jsonString != null) {
      return true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(UserResponseModel userResponseModel) {
    return sharedPreferences.setString(
        KStrings.getExistingUserResponseKey, userResponseModel.toJson());
  }

  @override
  UserResponseModel getExistingUserInfo() {
    final jsonData =
        sharedPreferences.getString(KStrings.getExistingUserResponseKey);
    if (jsonData != null) {
      return UserResponseModel.fromJson(jsonData);
    } else {
      throw const DatabaseException('Not save users');
    }
  }

  @override
  Future<bool> clearUserResponse() {
    return sharedPreferences.remove(KStrings.getExistingUserResponseKey);
  }

  @override
  Future<bool> cacheRestaurantResponse(
      RestaurantLoginResponse restaurantLoginResponse) {
    return sharedPreferences.setString(
        KStrings.getExistingRestaurantResponseKey,
        restaurantLoginResponse.toJson());
  }

  @override
  RestaurantLoginResponse getExistingRestaurantInfo() {
    final jsonData =
        sharedPreferences.getString(KStrings.getExistingRestaurantResponseKey);
    if (jsonData != null) {
      return RestaurantLoginResponse.fromJson(jsonData);
    } else {
      throw const DatabaseException('Not save users');
    }
  }
}
