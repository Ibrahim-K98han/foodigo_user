class RemoteUrls {
  // static const String rootUrl = "https://foodigo.alenterprisebd.com/";
  static const String rootUrl = "https://minionionbd.com/foodigo/";
  static const String paymentUrl =
      " https://minionionbd.com/foodigo/payment-api";
  static const String baseUrl = '${rootUrl}api/v1/';

  static const String homeData = '${baseUrl}home';
  static const String restaurantsData = '${baseUrl}restaurants';

  static String singleRestaurantsData(String slug) =>
      '${baseUrl}restaurants/$slug';
  static const String getCartData = '${baseUrl}cart';
  static const String clearCart = '${baseUrl}cart/clear';

  static String productDetailsData(int id) => '${baseUrl}products/$id';

  static const String login = '${baseUrl}auth/login';
  static const String getProfile = '${baseUrl}auth/profile';
  static const String updateProfile = '${baseUrl}auth/profile';
  static const String addProduct = '${baseUrl}cart/add';

  static String deleteProduct(String id) => '${baseUrl}cart/remove/$id';

  static String incrementProduct(String id) => '${baseUrl}cart/increment/$id';

  static String decrementProduct(String id) => '${baseUrl}cart/decrement/$id';

  static const String getAddress = '${baseUrl}dashboard/addresses';
  static const String addAddress = '${baseUrl}dashboard/addresses';

  static String updateAddress(String id) => '${baseUrl}dashboard/addresses/$id';

  static String deleteAddress(String id) => '${baseUrl}dashboard/addresses/$id';
  static const String checkOut = '${baseUrl}checkout/validate';
  static const String getOrder = '${baseUrl}dashboard/orders';

  static String orderDetails(String id) => '${baseUrl}dashboard/orders/$id';
  static const String getWishList = '${baseUrl}wishlist';
  static const String addWishList = '${baseUrl}wishlist/add';

  static String removeWishList(String id) => '${baseUrl}wishlist/remove/$id';
  static const String getReview = '${baseUrl}dashboard/reviews';
  static const String getSearch = '${baseUrl}home/search';
  static const String logout = '${baseUrl}auth/logout';
  static const String register = '${baseUrl}auth/register';
  static const String otpVerify = '${baseUrl}auth/verify-email';
  static const String resendVerificationCode =
      '${baseUrl}auth/resend-verification';
  static const String forgotPassword = '${baseUrl}auth/forgot-password';
  static const String resetPassword = '${baseUrl}auth/reset-password';
  static const String applyCoupon = '${baseUrl}cart/coupon/apply';
  static const String getAllPaymentMethod =
      '${baseUrl}checkout/payment-methods';
  static const String changeProfilePass = '${baseUrl}auth/change-password';

  static const String payWithBank = '${baseUrl}payment/bank';
  static const String payWithStripe = '${rootUrl}payment-api/pay-with-stripe';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;
}
