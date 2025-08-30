class RemoteUrls {
  // static const String rootUrl = "https://foodigo.alenterprisebd.com/";
  static const String rootUrl = "https://minionionbd.com/foodigo/";
  static const String baseUrl = '${rootUrl}api/v1/';

  static const String homeData = '${baseUrl}home';
  static const String restaurantsData = '${baseUrl}restaurants';

  static String singleRestaurantsData(String slug) =>
      '${baseUrl}restaurants/$slug';
  static const String getCartData = '${baseUrl}cart';

  static String productDetailsData(int id) => '${baseUrl}products/$id';

  static const String login = '${baseUrl}auth/login';
  static const String getProfile = '${baseUrl}auth/profile';
  static const String addProduct = '${baseUrl}cart/add';
  static const String getAddress = '${baseUrl}dashboard/addresses';

  static String deleteAddress(String id) => '${baseUrl}dashboard/addresses/$id';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;
}
