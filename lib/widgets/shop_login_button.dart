import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:hirome_rental_information_web/common/style.dart';

class ShopLoginButton extends StatelessWidget {
  final int value;
  final Function()? onTap;

  const ShopLoginButton({
    required this.value,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (value == 0) {
      return GestureDetector(
        onTap: onTap,
        child: const Text(
          '店舗ログイン一覧',
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 16,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: badges.Badge(
        badgeStyle: const badges.BadgeStyle(
          badgeColor: kRedColor,
          elevation: 0,
        ),
        badgeContent: Text(
          '$value',
          style: const TextStyle(color: kWhiteColor),
        ),
        position: badges.BadgePosition.topEnd(
          top: -10,
          end: -5,
        ),
        child: const Text(
          '店舗ログイン一覧',
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
