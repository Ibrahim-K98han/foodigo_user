import 'package:flutter/material.dart';

class ItemNameText extends StatelessWidget {
  const ItemNameText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 16,
        fontFamily: 'Agrandir',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class CategoryNameText extends StatelessWidget {
  const CategoryNameText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF1778F2),
        fontSize: 12,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      "\$$text",
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 16,
        fontFamily: 'Agrandir',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
