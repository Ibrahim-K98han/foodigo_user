class RemoteUrls {
  static const String rootUrl = "https://foodigo.alenterprisebd.com/";
  static const String baseUrl = '${rootUrl}api/v1/';

  static const String homeData = '${baseUrl}home';
  static const String restaurantsData = '${baseUrl}restaurants';

  static String singleRestaurantsData(String slug) =>
      '${baseUrl}restaurants/$slug';
  static const String getCartData = '${baseUrl}cart';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;
}
