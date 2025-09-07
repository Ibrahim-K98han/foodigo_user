import 'package:equatable/equatable.dart';

class PaymentMethodModel extends Equatable {
  final String stripeStatus;
  final String stripeImage;
  final String stripeKey;
  final String stripeSecret;

  final String paypalStatus;
  final String paypalImage;
  final String paypalClientId;
  final String paypalSecret;

  final String razorpayStatus;
  final String razorpayImage;
  final String razorpayKey;
  final String razorpaySecret;

  final String flutterwaveStatus;
  final String flutterwaveLogo;
  final String flutterwavePublicKey;
  final String flutterwaveSecretKey;

  final String mollieStatus;
  final String mollieImage;
  final String mollieKey;

  final String paystackStatus;
  final String paystackImage;
  final String paystackPublicKey;
  final String paystackSecretKey;

  final String instamojoStatus;
  final String instamojoImage;
  final String instamojoApiKey;
  final String instamojoAuthToken;

  final String bankStatus;
  final String bankImage;
  final String bankAccountInfo;

  const PaymentMethodModel({
    required this.stripeStatus,
    required this.stripeImage,
    required this.stripeKey,
    required this.stripeSecret,
    required this.paypalStatus,
    required this.paypalImage,
    required this.paypalClientId,
    required this.paypalSecret,
    required this.razorpayStatus,
    required this.razorpayImage,
    required this.razorpayKey,
    required this.razorpaySecret,
    required this.flutterwaveStatus,
    required this.flutterwaveLogo,
    required this.flutterwavePublicKey,
    required this.flutterwaveSecretKey,
    required this.mollieStatus,
    required this.mollieImage,
    required this.mollieKey,
    required this.paystackStatus,
    required this.paystackImage,
    required this.paystackPublicKey,
    required this.paystackSecretKey,
    required this.instamojoStatus,
    required this.instamojoImage,
    required this.instamojoApiKey,
    required this.instamojoAuthToken,
    required this.bankStatus,
    required this.bankImage,
    required this.bankAccountInfo,
  });

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      stripeStatus: map["stripe_status"] ?? "",
      stripeImage: map["stripe_image"] ?? "",
      stripeKey: map["stripe_key"] ?? "",
      stripeSecret: map["stripe_secret"] ?? "",
      paypalStatus: map["paypal_status"] ?? "",
      paypalImage: map["paypal_image"] ?? "",
      paypalClientId: map["paypal_client_id"] ?? "",
      paypalSecret: map["paypal_secret_key"] ?? "",
      razorpayStatus: map["razorpay_status"] ?? "",
      razorpayImage: map["razorpay_image"] ?? "",
      razorpayKey: map["razorpay_key"] ?? "",
      razorpaySecret: map["razorpay_secret"] ?? "",
      flutterwaveStatus: map["flutterwave_status"] ?? "",
      flutterwaveLogo: map["flutterwave_logo"] ?? "",
      flutterwavePublicKey: map["flutterwave_public_key"] ?? "",
      flutterwaveSecretKey: map["flutterwave_secret_key"] ?? "",
      mollieStatus: map["mollie_status"] ?? "",
      mollieImage: map["mollie_image"] ?? "",
      mollieKey: map["mollie_key"] ?? "",
      paystackStatus: map["paystack_status"] ?? "",
      paystackImage: map["paystack_image"] ?? "",
      paystackPublicKey: map["paystack_public_key"] ?? "",
      paystackSecretKey: map["paystack_secret_key"] ?? "",
      instamojoStatus: map["instamojo_status"] ?? "",
      instamojoImage: map["instamojo_image"] ?? "",
      instamojoApiKey: map["instamojo_api_key"] ?? "",
      instamojoAuthToken: map["instamojo_auth_token"] ?? "",
      bankStatus: map["bank_status"] ?? "",
      bankImage: map["bank_image"] ?? "",
      bankAccountInfo: map["bank_account_info"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
        stripeStatus,
        stripeImage,
        stripeKey,
        stripeSecret,
        paypalStatus,
        paypalImage,
        paypalClientId,
        paypalSecret,
        razorpayStatus,
        razorpayImage,
        razorpayKey,
        razorpaySecret,
        flutterwaveStatus,
        flutterwaveLogo,
        flutterwavePublicKey,
        flutterwaveSecretKey,
        mollieStatus,
        mollieImage,
        mollieKey,
        paystackStatus,
        paystackImage,
        paystackPublicKey,
        paystackSecretKey,
        instamojoStatus,
        instamojoImage,
        instamojoApiKey,
        instamojoAuthToken,
        bankStatus,
        bankImage,
        bankAccountInfo,
      ];
}
