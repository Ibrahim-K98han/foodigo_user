import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state.dart';

class ForgotPasswordStateModel extends Equatable {
  final String email;
  final String code;
  final String otp;
  final String password;
  final String languageCode;
  final String confirmPassword;
  final bool showPassword;
  final bool showConfirmPassword;
  final ForgotPasswordState passwordState;

  const ForgotPasswordStateModel({
    this.email = '',
    this.otp = '',
    this.code = '',
    this.password = '',
    this.languageCode = '',
    this.confirmPassword = '',
    this.showPassword = true,
    this.showConfirmPassword = true,
    this.passwordState = const ForgotPasswordStateInitial(),
  });

  ForgotPasswordStateModel copyWith({
    String? email,
    String? otp,
    String? code,
    String? password,
    String? languageCode,
    String? confirmPassword,
    bool? showPassword,
    bool? showConfirmPassword,
    ForgotPasswordState? passwordState,
  }) {
    return ForgotPasswordStateModel(
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      languageCode: languageCode ?? this.languageCode,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      passwordState: passwordState ?? this.passwordState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'otp': otp,
      'token': code,
      'password': password,
      'c_password': confirmPassword,
      'lang_code': languageCode,
      // 'showPassword': showPassword,
      // 'showConfirmPassword': showConfirmPassword,
    };
  }

  static ForgotPasswordStateModel init() {
    return const ForgotPasswordStateModel(
      email: '',
      otp: '',
      code: '',
      password: '',
      languageCode: '',
      confirmPassword: '',
      showPassword: true,
      showConfirmPassword: true,
      passwordState: ForgotPasswordStateInitial(),
    );
  }

  ForgotPasswordStateModel clear() {
    return const ForgotPasswordStateModel(
      email: '',
      otp: '',
      code: '',
      password: '',
      confirmPassword: '',
      showPassword: true,
      showConfirmPassword: true,
      passwordState: ForgotPasswordStateInitial(),
    );
  }

  factory ForgotPasswordStateModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordStateModel(
      email: map['email'] ?? '',
      otp: map['otp'] ?? '',
      code: map['token'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['password_confirmation'] ?? '',
      showPassword: map['showPassword'] ?? false,
      showConfirmPassword: map['showConfirmPassword'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordStateModel.fromJson(String source) =>
      ForgotPasswordStateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PasswordStateModel(email: $email, code: $code, password: $password, confirmPassword: $confirmPassword, showPassword: $showPassword, showConfirmPassword: $showConfirmPassword, passwordState: $passwordState)';
  }

  @override
  List<Object> get props {
    return [
      email,
      otp,
      code,
      password,
      languageCode,
      confirmPassword,
      showPassword,
      showConfirmPassword,
      passwordState,
    ];
  }
}
