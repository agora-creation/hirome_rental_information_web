import 'package:flutter/material.dart';
import 'package:hirome_rental_information_web/models/shop_login.dart';
import 'package:hirome_rental_information_web/services/shop_login.dart';

class ShopLoginProvider with ChangeNotifier {
  ShopLoginService shopLoginService = ShopLoginService();

  Future<String?> accept(ShopLoginModel shopLogin) async {
    String? error;
    try {
      shopLoginService.update({
        'id': shopLogin.id,
        'accept': true,
        'acceptedAt': DateTime.now(),
      });
    } catch (e) {
      error = '承認に失敗しました';
    }
    return error;
  }

  Future<String?> delete(ShopLoginModel shopLogin) async {
    String? error;
    try {
      shopLoginService.delete({'id': shopLogin.id});
    } catch (e) {
      error = 'ブロックに失敗しました';
    }
    return error;
  }
}
