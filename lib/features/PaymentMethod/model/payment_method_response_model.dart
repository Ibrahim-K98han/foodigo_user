// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class PaymentMethodResponseModel extends Equatable {
  final bool success;
  final String message;
  final Data? data;

  const PaymentMethodResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  PaymentMethodResponseModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return PaymentMethodResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory PaymentMethodResponseModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodResponseModel(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      data: map['data'] != null
          ? Data.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodResponseModel.fromJson(String source) =>
      PaymentMethodResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [success, message, data];
}

class Data extends Equatable {
  final PaymentMethods? paymentMethods;

  const Data({
    this.paymentMethods,
  });

  Data copyWith({
    PaymentMethods? paymentMethods,
  }) {
    return Data(
      paymentMethods: paymentMethods ?? this.paymentMethods,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payment_methods': paymentMethods?.toMap(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      paymentMethods: map['payment_methods'] != null
          ? PaymentMethods.fromMap(map['payment_methods'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [paymentMethods];
}

class PaymentMethods extends Equatable {
  final String stripeStatus;
  final String stripeImage;
  final String stripeCurrencyId;
  final String stripeKey;
  final String stripeSecret;
  final String paypalStatus;
  final String paypalImage;
  final String paypalAccountMode;
  final String paypalCurrencyId;
  final String paypalClientId;
  final String paypalSecretKey;
  final String razorpayStatus;
  final String razorpayImage;
  final String razorpayCurrencyId;
  final String razorpayKey;
  final String razorpaySecret;
  final String razorpayName;
  final String razorpayDescription;
  final String razorpayThemeColor;
  final String flutterwaveStatus;
  final String flutterwaveLogo;
  final String flutterwaveCurrencyId;
  final String flutterwavePublicKey;
  final String flutterwaveSecretKey;
  final String flutterwaveTitle;
  final String mollieStatus;
  final String mollieImage;
  final String mollieCurrencyId;
  final String mollieKey;
  final String paystackStatus;
  final String paystackImage;
  final String paystackCurrencyId;
  final String paystackPublicKey;
  final String paystackSecretKey;
  final String instamojoStatus;
  final String instamojoImage;
  final String instamojoAccountMode;
  final String instamojoCurrencyId;
  final String instamojoApiKey;
  final String instamojoAuthToken;
  final String bankStatus;
  final String bankImage;
  final String bankAccountInfo;

  const PaymentMethods({
    required this.stripeStatus,
    required this.stripeImage,
    required this.stripeCurrencyId,
    required this.stripeKey,
    required this.stripeSecret,
    required this.paypalStatus,
    required this.paypalImage,
    required this.paypalAccountMode,
    required this.paypalCurrencyId,
    required this.paypalClientId,
    required this.paypalSecretKey,
    required this.razorpayStatus,
    required this.razorpayImage,
    required this.razorpayCurrencyId,
    required this.razorpayKey,
    required this.razorpaySecret,
    required this.razorpayName,
    required this.razorpayDescription,
    required this.razorpayThemeColor,
    required this.flutterwaveStatus,
    required this.flutterwaveLogo,
    required this.flutterwaveCurrencyId,
    required this.flutterwavePublicKey,
    required this.flutterwaveSecretKey,
    required this.flutterwaveTitle,
    required this.mollieStatus,
    required this.mollieImage,
    required this.mollieCurrencyId,
    required this.mollieKey,
    required this.paystackStatus,
    required this.paystackImage,
    required this.paystackCurrencyId,
    required this.paystackPublicKey,
    required this.paystackSecretKey,
    required this.instamojoStatus,
    required this.instamojoImage,
    required this.instamojoAccountMode,
    required this.instamojoCurrencyId,
    required this.instamojoApiKey,
    required this.instamojoAuthToken,
    required this.bankStatus,
    required this.bankImage,
    required this.bankAccountInfo,
  });

  PaymentMethods copyWith({
    String? stripeStatus,
    String? stripeImage,
    String? stripeCurrencyId,
    String? stripeKey,
    String? stripeSecret,
    String? paypalStatus,
    String? paypalImage,
    String? paypalAccountMode,
    String? paypalCurrencyId,
    String? paypalClientId,
    String? paypalSecretKey,
    String? razorpayStatus,
    String? razorpayImage,
    String? razorpayCurrencyId,
    String? razorpayKey,
    String? razorpaySecret,
    String? razorpayName,
    String? razorpayDescription,
    String? razorpayThemeColor,
    String? flutterwaveStatus,
    String? flutterwaveLogo,
    String? flutterwaveCurrencyId,
    String? flutterwavePublicKey,
    String? flutterwaveSecretKey,
    String? flutterwaveTitle,
    String? mollieStatus,
    String? mollieImage,
    String? mollieCurrencyId,
    String? mollieKey,
    String? paystackStatus,
    String? paystackImage,
    String? paystackCurrencyId,
    String? paystackPublicKey,
    String? paystackSecretKey,
    String? instamojoStatus,
    String? instamojoImage,
    String? instamojoAccountMode,
    String? instamojoCurrencyId,
    String? instamojoApiKey,
    String? instamojoAuthToken,
    String? bankStatus,
    String? bankImage,
    String? bankAccountInfo,
  }) {
    return PaymentMethods(
      stripeStatus: stripeStatus ?? this.stripeStatus,
      stripeImage: stripeImage ?? this.stripeImage,
      stripeCurrencyId: stripeCurrencyId ?? this.stripeCurrencyId,
      stripeKey: stripeKey ?? this.stripeKey,
      stripeSecret: stripeSecret ?? this.stripeSecret,
      paypalStatus: paypalStatus ?? this.paypalStatus,
      paypalImage: paypalImage ?? this.paypalImage,
      paypalAccountMode: paypalAccountMode ?? this.paypalAccountMode,
      paypalCurrencyId: paypalCurrencyId ?? this.paypalCurrencyId,
      paypalClientId: paypalClientId ?? this.paypalClientId,
      paypalSecretKey: paypalSecretKey ?? this.paypalSecretKey,
      razorpayStatus: razorpayStatus ?? this.razorpayStatus,
      razorpayImage: razorpayImage ?? this.razorpayImage,
      razorpayCurrencyId: razorpayCurrencyId ?? this.razorpayCurrencyId,
      razorpayKey: razorpayKey ?? this.razorpayKey,
      razorpaySecret: razorpaySecret ?? this.razorpaySecret,
      razorpayName: razorpayName ?? this.razorpayName,
      razorpayDescription: razorpayDescription ?? this.razorpayDescription,
      razorpayThemeColor: razorpayThemeColor ?? this.razorpayThemeColor,
      flutterwaveStatus: flutterwaveStatus ?? this.flutterwaveStatus,
      flutterwaveLogo: flutterwaveLogo ?? this.flutterwaveLogo,
      flutterwaveCurrencyId: flutterwaveCurrencyId ?? this.flutterwaveCurrencyId,
      flutterwavePublicKey: flutterwavePublicKey ?? this.flutterwavePublicKey,
      flutterwaveSecretKey: flutterwaveSecretKey ?? this.flutterwaveSecretKey,
      flutterwaveTitle: flutterwaveTitle ?? this.flutterwaveTitle,
      mollieStatus: mollieStatus ?? this.mollieStatus,
      mollieImage: mollieImage ?? this.mollieImage,
      mollieCurrencyId: mollieCurrencyId ?? this.mollieCurrencyId,
      mollieKey: mollieKey ?? this.mollieKey,
      paystackStatus: paystackStatus ?? this.paystackStatus,
      paystackImage: paystackImage ?? this.paystackImage,
      paystackCurrencyId: paystackCurrencyId ?? this.paystackCurrencyId,
      paystackPublicKey: paystackPublicKey ?? this.paystackPublicKey,
      paystackSecretKey: paystackSecretKey ?? this.paystackSecretKey,
      instamojoStatus: instamojoStatus ?? this.instamojoStatus,
      instamojoImage: instamojoImage ?? this.instamojoImage,
      instamojoAccountMode: instamojoAccountMode ?? this.instamojoAccountMode,
      instamojoCurrencyId: instamojoCurrencyId ?? this.instamojoCurrencyId,
      instamojoApiKey: instamojoApiKey ?? this.instamojoApiKey,
      instamojoAuthToken: instamojoAuthToken ?? this.instamojoAuthToken,
      bankStatus: bankStatus ?? this.bankStatus,
      bankImage: bankImage ?? this.bankImage,
      bankAccountInfo: bankAccountInfo ?? this.bankAccountInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stripe_status': stripeStatus,
      'stripe_image': stripeImage,
      'stripe_currency_id': stripeCurrencyId,
      'stripe_key': stripeKey,
      'stripe_secret': stripeSecret,
      'paypal_status': paypalStatus,
      'paypal_image': paypalImage,
      'paypal_account_mode': paypalAccountMode,
      'paypal_currency_id': paypalCurrencyId,
      'paypal_client_id': paypalClientId,
      'paypal_secret_key': paypalSecretKey,
      'razorpay_status': razorpayStatus,
      'razorpay_image': razorpayImage,
      'razorpay_currency_id': razorpayCurrencyId,
      'razorpay_key': razorpayKey,
      'razorpay_secret': razorpaySecret,
      'razorpay_name': razorpayName,
      'razorpay_description': razorpayDescription,
      'razorpay_theme_color': razorpayThemeColor,
      'flutterwave_status': flutterwaveStatus,
      'flutterwave_logo': flutterwaveLogo,
      'flutterwave_currency_id': flutterwaveCurrencyId,
      'flutterwave_public_key': flutterwavePublicKey,
      'flutterwave_secret_key': flutterwaveSecretKey,
      'flutterwave_title': flutterwaveTitle,
      'mollie_status': mollieStatus,
      'mollie_image': mollieImage,
      'mollie_currency_id': mollieCurrencyId,
      'mollie_key': mollieKey,
      'paystack_status': paystackStatus,
      'paystack_image': paystackImage,
      'paystack_currency_id': paystackCurrencyId,
      'paystack_public_key': paystackPublicKey,
      'paystack_secret_key': paystackSecretKey,
      'instamojo_status': instamojoStatus,
      'instamojo_image': instamojoImage,
      'instamojo_account_mode': instamojoAccountMode,
      'instamojo_currency_id': instamojoCurrencyId,
      'instamojo_api_key': instamojoApiKey,
      'instamojo_auth_token': instamojoAuthToken,
      'bank_status': bankStatus,
      'bank_image': bankImage,
      'bank_account_info': bankAccountInfo,
    };
  }

  factory PaymentMethods.fromMap(Map<String, dynamic> map) {
    return PaymentMethods(
      stripeStatus: map['stripe_status'] ?? '',
      stripeImage: map['stripe_image'] ?? '',
      stripeCurrencyId: map['stripe_currency_id'] ?? '',
      stripeKey: map['stripe_key'] ?? '',
      stripeSecret: map['stripe_secret'] ?? '',
      paypalStatus: map['paypal_status'] ?? '',
      paypalImage: map['paypal_image'] ?? '',
      paypalAccountMode: map['paypal_account_mode'] ?? '',
      paypalCurrencyId: map['paypal_currency_id'] ?? '',
      paypalClientId: map['paypal_client_id'] ?? '',
      paypalSecretKey: map['paypal_secret_key'] ?? '',
      razorpayStatus: map['razorpay_status'] ?? '',
      razorpayImage: map['razorpay_image'] ?? '',
      razorpayCurrencyId: map['razorpay_currency_id'] ?? '',
      razorpayKey: map['razorpay_key'] ?? '',
      razorpaySecret: map['razorpay_secret'] ?? '',
      razorpayName: map['razorpay_name'] ?? '',
      razorpayDescription: map['razorpay_description'] ?? '',
      razorpayThemeColor: map['razorpay_theme_color'] ?? '',
      flutterwaveStatus: map['flutterwave_status'] ?? '',
      flutterwaveLogo: map['flutterwave_logo'] ?? '',
      flutterwaveCurrencyId: map['flutterwave_currency_id'] ?? '',
      flutterwavePublicKey: map['flutterwave_public_key'] ?? '',
      flutterwaveSecretKey: map['flutterwave_secret_key'] ?? '',
      flutterwaveTitle: map['flutterwave_title'] ?? '',
      mollieStatus: map['mollie_status'] ?? '',
      mollieImage: map['mollie_image'] ?? '',
      mollieCurrencyId: map['mollie_currency_id'] ?? '',
      mollieKey: map['mollie_key'] ?? '',
      paystackStatus: map['paystack_status'] ?? '',
      paystackImage: map['paystack_image'] ?? '',
      paystackCurrencyId: map['paystack_currency_id'] ?? '',
      paystackPublicKey: map['paystack_public_key'] ?? '',
      paystackSecretKey: map['paystack_secret_key'] ?? '',
      instamojoStatus: map['instamojo_status'] ?? '',
      instamojoImage: map['instamojo_image'] ?? '',
      instamojoAccountMode: map['instamojo_account_mode'] ?? '',
      instamojoCurrencyId: map['instamojo_currency_id'] ?? '',
      instamojoApiKey: map['instamojo_api_key'] ?? '',
      instamojoAuthToken: map['instamojo_auth_token'] ?? '',
      bankStatus: map['bank_status'] ?? '',
      bankImage: map['bank_image'] ?? '',
      bankAccountInfo: map['bank_account_info'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethods.fromJson(String source) =>
      PaymentMethods.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    stripeStatus,
    stripeImage,
    stripeCurrencyId,
    stripeKey,
    stripeSecret,
    paypalStatus,
    paypalImage,
    paypalAccountMode,
    paypalCurrencyId,
    paypalClientId,
    paypalSecretKey,
    razorpayStatus,
    razorpayImage,
    razorpayCurrencyId,
    razorpayKey,
    razorpaySecret,
    razorpayName,
    razorpayDescription,
    razorpayThemeColor,
    flutterwaveStatus,
    flutterwaveLogo,
    flutterwaveCurrencyId,
    flutterwavePublicKey,
    flutterwaveSecretKey,
    flutterwaveTitle,
    mollieStatus,
    mollieImage,
    mollieCurrencyId,
    mollieKey,
    paystackStatus,
    paystackImage,
    paystackCurrencyId,
    paystackPublicKey,
    paystackSecretKey,
    instamojoStatus,
    instamojoImage,
    instamojoAccountMode,
    instamojoCurrencyId,
    instamojoApiKey,
    instamojoAuthToken,
    bankStatus,
    bankImage,
    bankAccountInfo,
  ];
}
