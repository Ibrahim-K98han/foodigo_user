import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../bloc/restaurant_login_state.dart';

class RestaurantLoginStateModel extends Equatable {
  final String email;
  final String password;
  final bool isActive;
  final bool show;

  final String languageCode;
  final String currencyCode;
  final String currencyIcon;
  final RestaurantLoginState restaurantLoginState;

  const RestaurantLoginStateModel(
      {this.email = 'restaurant@gmail.com',
      this.password = '1234',
      // this.email = '',
      // this.password = '',
      this.languageCode = 'en',
      this.currencyCode = '',
      this.currencyIcon = '',
      this.isActive = false,
      this.show = true,
      this.restaurantLoginState = const RestaurantLoginStateInitial()});

  // LoginStateInitial(),
  RestaurantLoginStateModel copyWith({
    String? email,
    String? password,
    String? languageCode,
    String? currencyCode,
    String? currencyIcon,
    bool? isActive,
    bool? isJobSeeker,
    bool? show,
    RestaurantLoginState? restaurantLoginState,
  }) {
    return RestaurantLoginStateModel(
      email: email ?? this.email,
      password: password ?? this.password,
      languageCode: languageCode ?? this.languageCode,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      isActive: isActive ?? this.isActive,
      show: show ?? this.show,
      restaurantLoginState: restaurantLoginState ?? this.restaurantLoginState,
    );
  }

  RestaurantLoginStateModel clear() {
    return const RestaurantLoginStateModel(
      email: '',
      password: '',
      languageCode: '',
      currencyCode: '',
      currencyIcon: '',
      isActive: false,
      show: true,
      restaurantLoginState: RestaurantLoginStateInitial(),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email.trim()});
    result.addAll({'password': password});
    // result.addAll({'state': state});

    return result;
  }

  factory RestaurantLoginStateModel.fromMap(Map<String, dynamic> map) {
    return RestaurantLoginStateModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantLoginStateModel.fromJson(String source) =>
      RestaurantLoginStateModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginModelState(username: $email, password: $password, state: $restaurantLoginState)';

  @override
  List<Object> get props => [
        email,
        password,
        languageCode,
        currencyCode,
        currencyIcon,
        isActive,
        show,
        restaurantLoginState,
      ];
}
