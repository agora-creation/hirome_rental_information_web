import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:hirome_rental_information_web/common/style.dart';

class ShopLoginButton extends StatelessWidget {
  final int value;
  final Function()? onPressed;

  const ShopLoginButton({
    required this.value,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (value == 0) {
      return TextButton(
        onPressed: onPressed,
        child: const Text(
          '店舗アカウントログイン',
          style: TextStyle(color: kWhiteColor),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: badges.Badge(
        badgeStyle: const badges.BadgeStyle(
          badgeColor: kRedColor,
          elevation: 0,
        ),
        badgeContent: Text(
          '$value',
          style: const TextStyle(color: kWhiteColor),
        ),
        position: badges.BadgePosition.topEnd(top: -15, end: -5),
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            '店舗アカウントログイン',
            style: TextStyle(color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}
