import 'package:flutter/material.dart';
import 'package:flutter_eshop_ecomm/provider/product_provider.dart';
import 'package:flutter_eshop_ecomm/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool viewFav;
  ProductsGrid(this.viewFav, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context); 
    final products = viewFav ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: ((ct, index) => ChangeNotifierProvider.value(
        value: products[index],
          child: ProductItem())),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
