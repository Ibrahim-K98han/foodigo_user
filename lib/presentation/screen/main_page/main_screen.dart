import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/GetProfile/cubit/get_profile_cubit.dart';
import '../home/home_screen.dart';
import '../my_cart/my_cart_screen.dart';
import '../my_order/my_order_screen.dart';
import '../profile/profile_screen.dart';
import 'component/bottom_navigation_bar copy.dart';
import 'component/main_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _homeController = MainController();
  late List<Widget> screenList;

  @override
  void initState() {
    super.initState();
    screenList = [
      const HomeScreen(),
      const MyCartScreen(),
      const MyOrderScreen(),
      const ProfileScreen(),
    ];
    context.read<GetProfileCubit>().getProfileData();
    // context.read<CartCubit>().getCartData();
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
