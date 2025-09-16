import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../my_menu/my_menu_screen.dart';
import '../my_order/my_order_screen.dart';
import '../profile/profile_screen.dart';
import 'component/bottom_navigation_bar copy.dart';
import 'component/main_controller.dart';


class RestaurantMainScreen extends StatefulWidget {
  const RestaurantMainScreen({super.key});

  @override
  State<RestaurantMainScreen> createState() => _RestaurantMainScreenState();
}

class _RestaurantMainScreenState extends State<RestaurantMainScreen> {
  final _homeController = MainController();
  late List<Widget> screenList;

  @override
  void initState() {
    super.initState();
    screenList = [
      const HomeScreen(),
      const MyMenuScreen(),
      const MyOrderScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //exitApp(context);
        return true;
      },
      child: Scaffold(
        body: StreamBuilder<int>(
          initialData: 0,
          stream: _homeController.naveListener.stream,
          builder: (context, AsyncSnapshot<int> snapshot) {
            int item = snapshot.data ?? 0;
            return screenList[item];
          },
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
