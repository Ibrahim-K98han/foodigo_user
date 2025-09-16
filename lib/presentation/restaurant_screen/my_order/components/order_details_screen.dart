import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_appbar.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: 'Order Details'),
      body: Column(children: [

      ],),
    );
  }
}
