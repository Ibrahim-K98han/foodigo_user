import 'dart:async';

class MainController {
  static final MainController _instance = MainController._internal();
  factory MainController() => _instance;
  MainController._internal();

  final naveListener = StreamController<int>.broadcast();

  void changeTab(int index) {
    naveListener.sink.add(index);
  }

  void dispose() {
    naveListener.close();
  }
}
