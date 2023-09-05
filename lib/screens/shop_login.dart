import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hirome_rental_information_web/common/functions.dart';
import 'package:hirome_rental_information_web/common/style.dart';
import 'package:hirome_rental_information_web/models/shop_login.dart';
import 'package:hirome_rental_information_web/providers/auth.dart';
import 'package:hirome_rental_information_web/providers/shop_login.dart';
import 'package:hirome_rental_information_web/services/shop_login.dart';
import 'package:hirome_rental_information_web/widgets/shop_login_list.dart';
import 'package:provider/provider.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  ShopLoginService shopLoginService = ShopLoginService();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final shopLoginProvider = Provider.of<ShopLoginProvider>(context);

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        title: Text(
          '${authProvider.shop?.name} : 店舗ログイン申請',
          style: const TextStyle(color: kBlackColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: kBlackColor),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 400),
        child: Column(
          children: [
            const Text(
              '各店舗が注文するアプリで、店舗アカウントのログインがあった場合に、二段階認証の為、こちらにログイン申請が送られます。\n『承認』するまでは、店舗はログインできません。身に覚えのないログイン申請は『却下』してください。',
              style: TextStyle(
                color: kGrey2Color,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: kGreyColor),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: shopLoginService.streamList(),
                builder: (context, snapshot) {
                  List<ShopLoginModel> shopLogins = [];
                  if (snapshot.hasData) {
                    for (DocumentSnapshot<Map<String, dynamic>> doc
                        in snapshot.data!.docs) {
                      shopLogins.add(ShopLoginModel.fromSnapshot(doc));
                    }
                  }
                  if (shopLogins.isEmpty) {
                    return const Center(
                      child: Text('ログイン申請がありません'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: shopLogins.length,
                    itemBuilder: (context, index) {
                      ShopLoginModel shopLogin = shopLogins[index];
                      return ShopLoginList(
                        shopLogin: shopLogin,
                        acceptOnPressed: () async {
                          String? error =
                              await shopLoginProvider.accept(shopLogin);
                          if (error != null) {
                            if (!mounted) return;
                            showMessage(context, error, false);
                            return;
                          }
                          if (!mounted) return;
                          showMessage(context, '承認しました', true);
                        },
                        rejectOnPressed: () async {
                          String? error =
                              await shopLoginProvider.reject(shopLogin);
                          if (error != null) {
                            if (!mounted) return;
                            showMessage(context, error, false);
                            return;
                          }
                          if (!mounted) return;
                          showMessage(context, '却下しました', true);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
