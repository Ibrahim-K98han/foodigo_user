import 'dart:async';

class RestaurantMainController {
  static final RestaurantMainController _instance =
      RestaurantMainController._internal();
  factory RestaurantMainController() => _instance;
  RestaurantMainController._internal();

  final naveListener = StreamController<int>.broadcast();

  void changeTab(int index) {
    naveListener.sink.add(index);
  }

  void dispose() {
    naveListener.close();
  }
}
