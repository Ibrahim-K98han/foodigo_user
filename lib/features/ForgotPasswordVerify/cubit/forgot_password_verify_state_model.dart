import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state.dart';

import 'forgot_password_verify_state.dart';

class ForgotPasswordVerifyStateModel extends Equatable {
  final String newPass;
  final String conPass;
  final bool showNewPass;
  final bool showConPass;
  final String email;
  final String code;
  final String otp;
  final String password;
  final String languageCode;
  final String confirmPassword;
  final bool showPassword;
  final bool showConfirmPassword;
  final ForgotPasswordVerifyState passwordState;

  const ForgotPasswordVerifyStateModel({
    this.newPass = '',
    this.conPass = '',
    this.showNewPass = true,
    this.showConPass = true,
    this.email = '',
    this.otp = '',
    this.code = '',
    this.password = '',
    this.languageCode = '',
    this.confirmPassword = '',
    this.showPassword = true,
    this.showConfirmPassword = true,
    this.passwordState = const ForgotPasswordVerifyStateInitial(),
  });

  ForgotPasswordVerifyStateModel copyWith({
    String? newPass,
    String? conPass,
    bool? showNewPass,
    bool? showConPass,
    String? email,
    String? otp,
    String? code,
    String? password,
    String? languageCode,
    String? confirmPassword,
    bool? showPassword,
    bool? showConfirmPassword,
    ForgotPasswordVerifyState? passwordState,
  }) {
    return ForgotPasswordVerifyStateModel(
      newPass: newPass ?? this.newPass,
      conPass: conPass ?? this.conPass,
      showNewPass: showNewPass ?? this.showNewPass,
      showConPass: showConPass ?? this.showConPass,
      email: email ?? this.email,
      otp: otp ?? this.otp,
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

  static ForgotPasswordVerifyStateModel init() {
    return const ForgotPasswordVerifyStateModel(
      newPass: '',
      conPass: '',
      showNewPass: true,
      showConPass:true,
      email: '',
      otp: '',
      code: '',
      password: '',
      languageCode: '',
      confirmPassword: '',
      showPassword: true,
      showConfirmPassword: true,
      passwordState: ForgotPasswordVerifyStateInitial(),
    );
  }

  ForgotPasswordVerifyStateModel clear() {
    return const ForgotPasswordVerifyStateModel(
      newPass: '',
      conPass: '',
      showNewPass: true,
      showConPass: true,
      email: '',
      otp: '',
      code: '',
      password: '',
      confirmPassword: '',
      showPassword: true,
      showConfirmPassword: true,
      passwordState: ForgotPasswordVerifyStateInitial(),
    );
  }

  factory ForgotPasswordVerifyStateModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordVerifyStateModel(
      conPass: map['password'] ?? '',
      newPass: map['password_confirmation'] ?? '',
      showNewPass: map['show_password'] ?? false,
      showConPass: map['show_confirmPassword']  ?? false,
      email: map['email'] ?? '',
      otp: map['otp'] ?? '',
      code: map['token'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['password_confirmation'] ?? '',
      showPassword: map['show_password'] ?? false,
      showConfirmPassword: map['show_confirmPassword'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordVerifyStateModel.fromJson(String source) =>
      ForgotPasswordVerifyStateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PasswordStateModel(email: $email, code: $code, password: $password, confirmPassword: $confirmPassword, showPassword: $showPassword, showConfirmPassword: $showConfirmPassword, passwordState: $passwordState)';
  }

  @override
  List<Object> get props {
    return [
      newPass,
      conPass,
      showNewPass,
      showConPass,
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
