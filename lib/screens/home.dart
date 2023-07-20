import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hirome_rental_information_web/common/style.dart';
import 'package:hirome_rental_information_web/models/product.dart';
import 'package:hirome_rental_information_web/providers/auth.dart';
import 'package:hirome_rental_information_web/services/product.dart';
import 'package:hirome_rental_information_web/widgets/cart_next_button.dart';
import 'package:hirome_rental_information_web/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('${authProvider.shop?.name} : 注文'),
        actions: [
          TextButton(
            child: const Text(
              '注文履歴',
              style: TextStyle(color: kWhiteColor),
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text(
            '注文したい商品をタップしてください',
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: productService.streamList(),
              builder: (context, snapshot) {
                List<ProductModel> products = [];
                List<String> favorites = authProvider.shop?.favorites ?? [];
                if (snapshot.hasData) {
                  for (DocumentSnapshot<Map<String, dynamic>> doc
                      in snapshot.data!.docs) {
                    ProductModel product = ProductModel.fromSnapshot(doc);
                    var contain = favorites.where((e) => e == product.number);
                    if (contain.isNotEmpty) {
                      products.add(product);
                    }
                  }
                }
                if (products.isEmpty) {
                  return const Center(
                    child: Text(
                      '注文できる商品がありません\n注文商品設定をご確認ください',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: kProductGrid,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    ProductModel product = products[index];
                    return ProductCard(
                      product: product,
                      carts: authProvider.carts,
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: CartNextButton(
        carts: authProvider.carts,
        onPressed: () {},
      ),
    );
  }
}
