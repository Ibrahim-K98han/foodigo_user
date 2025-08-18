import 'package:flutter/material.dart';
import 'package:foodigo/presentation/screen/all_restaurant_screen/components/best_selling_screen.dart';
import 'package:foodigo/widget/custom_appbar.dart';

import '../../../../utils/utils.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Wishlist'),
      body: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 40,
              offset: Offset(0, 2),
              spreadRadius: 10,
            )
          ],
        ),
        child: Padding(
          padding: Utils.symmetric(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ...List.generate(10, (index) {
                  return Padding(
                    padding: Utils.only(bottom: 12.0),
                    child: const ProductCard(),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
