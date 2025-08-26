class RemoteUrls{
  static const String rootUrl = "https://foodigo.alenterprisebd.com/";
  static const String baseUrl = '${rootUrl}api/v1/';

  static const String homeData = '${baseUrl}home';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;

}