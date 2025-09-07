// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../cubit/register_state.dart';

class RegisterStateModel extends Equatable {
  final String email;
  final int resendSeconds;
  final bool isResendActive;
  final String name;
  final String currentPassword;
  final String password;
  final String confirmPassword;
  final String phone;
  final String otp;
  final bool isActive;
  final String languageCode;
  final bool showPassword;
  final bool showConPassword;
  final RegisterState registerState;

  const RegisterStateModel({
    required this.email,
    this.resendSeconds = 60,
    this.isResendActive = false,
    required this.name,
    required this.currentPassword,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.otp,
    this.isActive = false,
    this.languageCode = 'en',
    this.showPassword = true,
    this.showConPassword = true,
    this.registerState = const RegisterInitial(),
  });

  RegisterStateModel copyWith({
    String? email,
    int? resendSeconds,
    bool? isResendActive,
    String? name,
    String? password,
    String? currentPassword,
    String? confirmPassword,
    String? phone,
    String? otp,
    bool? isActive,
    String? languageCode,
    bool? showPassword,
    bool? showConPassword,
    RegisterState? registerState,
  }) {
    return RegisterStateModel(
      email: email ?? this.email,
      resendSeconds: resendSeconds ?? this.resendSeconds,
      isResendActive: isResendActive ?? this.isResendActive,
      name: name ?? this.name,
      password: password ?? this.password,
      currentPassword: currentPassword ?? this.currentPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      isActive: isActive ?? this.isActive,
      languageCode: languageCode ?? this.languageCode,
      showPassword: showPassword ?? this.showPassword,
      showConPassword: showConPassword ?? this.showConPassword,
      registerState: registerState ?? this.registerState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'password': password,
      'current_password': currentPassword,
      'password_confirmation': confirmPassword,
      'phone': phone,
      'otp': otp,
    };
  }

  factory RegisterStateModel.fromMap(Map<String, dynamic> map) {
    return RegisterStateModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      currentPassword: map['current_password'] ?? '',
      confirmPassword: map['password_confirmation'] ?? '',
      phone: map['phone'] ?? '',
      otp: map['otp'] ?? '',
    );
  }

  RegisterStateModel clear() {
    return const RegisterStateModel(
      email: '',
      name: '',
      password: '',
      currentPassword: '',
      confirmPassword: '',
      phone: '',
      otp: '',
      showPassword: true,
      showConPassword: true,
      registerState: RegisterInitial(),
    );
  }

  static RegisterStateModel init() {
    return const RegisterStateModel(
      email: '',
      name: '',
      password: '',
      currentPassword: '',
      confirmPassword: '',
      phone: '',
      otp: '',
      showPassword: true,
      showConPassword: true,
      registerState: RegisterInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterStateModel.fromJson(String source) =>
      RegisterStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        email,
        resendSeconds,
        isResendActive,
        name,
        password,
        currentPassword,
        confirmPassword,
        phone,
        otp,
        isActive,
        languageCode,
        showPassword,
        showConPassword,
        registerState,
      ];
}
