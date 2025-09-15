import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import 'main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return Container(
      height: Platform.isAndroid ? 110 : 110,
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 40,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: StreamBuilder(
          initialData: 0,
          stream: controller.naveListener.stream,
          builder: (_, AsyncSnapshot<int> index) {
            int selectedIndex = index.data ?? 0;
            return BottomNavigationBar(
              selectedItemColor: primaryColor,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  tooltip: 'Home',
                  icon: _navIcon(KImages.homeInActive, primaryColor),
                  activeIcon: _navIcon(KImages.homeActive, primaryColor),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  tooltip: " My Menu",
                  icon: _navIcon(KImages.message, primaryColor),
                  activeIcon: _navIcon(KImages.message, primaryColor),
                  label: 'My Menu',
                ),
                BottomNavigationBarItem(
                  tooltip: 'My Order',
                  icon: _navIcon(KImages.orderInActive, primaryColor),
                  activeIcon: _navIcon(KImages.orderActive, primaryColor),
                  label: 'My Order',
                ),
                BottomNavigationBarItem(
                  tooltip: 'Menu',
                  icon: _navIcon(KImages.message, primaryColor),
                  activeIcon: _navIcon(KImages.message, primaryColor),
                  label: 'Menu',
                ),
              ],
              // type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (int index) {
                controller.naveListener.sink.add(index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _navIcon(String path, Color color) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SvgPicture.asset(
        path,
        color: color,
      ));
}
