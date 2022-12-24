import 'package:flutter/material.dart';
import 'package:flutter_eshop_ecomm/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../provider/carts.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  // const ProductDetailsScreen({this.title, super.key});
  // final title;
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments
        as String; //route = modalroute get data // constructor !=! central state management
    final loadedProduct =
        Provider.of<ProductProvider>(context).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            loadedProduct.title!,
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: 8,
          ),
          Text('\$${loadedProduct.price}'),
          SizedBox(
            height: 8,
          ),
          Text(
            loadedProduct.description!,
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 122.0),
            child: ElevatedButton(
              child: Row(
                children: [
                  Text('Add to cart'),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 32,
                  ),
                ],
              ),
              onPressed: () {
                cart.addItem(loadedProduct.id!, loadedProduct.price!,
                    loadedProduct.title!);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Added to cart',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      cart.removeSingleItem(loadedProduct.id!);
                    },
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
