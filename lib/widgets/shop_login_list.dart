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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: shopLogin.accept == false ? kRedColor.withOpacity(0.3) : null,
        border: const Border(bottom: BorderSide(color: kGreyColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      shopLogin.shopName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      shopLogin.accept ? 'でログイン中' : 'でログイン申請がありました',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '申請日時 : ${dateText('yyyy/MM/dd HH:mm', shopLogin.createdAt)}',
                  style: const TextStyle(fontSize: 12),
                ),
                shopLogin.accept
                    ? Text(
                        '承認日時 : ${dateText('yyyy/MM/dd HH:mm', shopLogin.acceptedAt)}',
                        style: const TextStyle(fontSize: 12),
                      )
                    : Container(),
                Text(
                  '申請者名 : ${shopLogin.requestName}、端末名 : ${shopLogin.deviceName}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              shopLogin.accept == false
                  ? TextButton(
                      onPressed: acceptOnPressed,
                      style: TextButton.styleFrom(
                        backgroundColor: kBlueColor,
                        padding: const EdgeInsets.all(8),
                      ),
                      child: const Text(
                        '承認する',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(width: 4),
              TextButton(
                onPressed: rejectOnPressed,
                style: TextButton.styleFrom(
                  backgroundColor: kRedColor,
                  padding: const EdgeInsets.all(8),
                ),
                child: const Text(
                  'ブロックする',
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
