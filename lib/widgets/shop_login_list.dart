import 'package:flutter/material.dart';
import 'package:hirome_rental_information_web/common/functions.dart';
import 'package:hirome_rental_information_web/common/style.dart';
import 'package:hirome_rental_information_web/models/shop_login.dart';

class ShopLoginList extends StatelessWidget {
  final ShopLoginModel shopLogin;
  final Function()? acceptOnPressed;
  final Function()? rejectOnPressed;

  const ShopLoginList({
    required this.shopLogin,
    required this.acceptOnPressed,
    required this.rejectOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGreyColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shopLogin.shopName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ログイン日時 : ${dateText('yyyy/MM/dd HH:mm', shopLogin.createdAt)}',
                  style: const TextStyle(
                    color: kGreyColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '申請者名 : ${shopLogin.requestName}',
                  style: const TextStyle(
                    color: kGreyColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '端末名 : ${shopLogin.deviceName}',
                  style: const TextStyle(
                    color: kGreyColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: acceptOnPressed,
                style: TextButton.styleFrom(
                  backgroundColor: kBlueColor,
                  padding: const EdgeInsets.all(8),
                ),
                child: const Text(
                  '承認',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              TextButton(
                onPressed: rejectOnPressed,
                style: TextButton.styleFrom(
                  backgroundColor: kRedColor,
                  padding: const EdgeInsets.all(8),
                ),
                child: const Text(
                  '却下',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
