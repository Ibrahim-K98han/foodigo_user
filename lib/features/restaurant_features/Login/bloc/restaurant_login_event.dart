import 'package:equatable/equatable.dart';

abstract class RestaurantLoginEvent extends Equatable {
  const RestaurantLoginEvent();

  @override
  List<Object?> get props => [];
}

class RestaurantLoginEventUserEmail extends RestaurantLoginEvent {
  final String email;

  const RestaurantLoginEventUserEmail(this.email);

  @override
  List<Object> get props => [email];
}

class RestaurantLoginEventPassword extends RestaurantLoginEvent {
  final String password;

  const RestaurantLoginEventPassword(this.password);

  @override
  List<Object> get props => [password];
}

class RestaurantSaveUserCredentialEvent extends RestaurantLoginEvent {
  final bool isActive;

  const RestaurantSaveUserCredentialEvent(this.isActive);

  @override
  List<Object> get props => [isActive];
}

class RestaurantShowPasswordEvent extends RestaurantLoginEvent {
  final bool show;

  const RestaurantShowPasswordEvent(this.show);

  @override
  List<Object> get props => [show];
}

class RestaurantLoginEventLanguageCode extends RestaurantLoginEvent {
  final String languageCode;

  const RestaurantLoginEventLanguageCode(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

class RestaurantLoginEventCurrencyIcon extends RestaurantLoginEvent {
  final String currencyIcon;

  const RestaurantLoginEventCurrencyIcon(this.currencyIcon);

  @override
  List<Object> get props => [currencyIcon];
}

class RestaurantLoginEventSubmit extends RestaurantLoginEvent {
  const RestaurantLoginEventSubmit();
}

class RestaurantLoginEventLogout extends RestaurantLoginEvent {
  const RestaurantLoginEventLogout();

  @override
  List<Object> get props => [];
}

class RestaurantLoginEventRememberMe extends RestaurantLoginEvent {}

class RestaurantLoginEventSaveCredential extends RestaurantLoginEvent {
  const RestaurantLoginEventSaveCredential();
}
