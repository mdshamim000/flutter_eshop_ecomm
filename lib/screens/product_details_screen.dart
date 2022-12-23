import 'package:flutter/material.dart';
import 'package:flutter_eshop_ecomm/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  // const ProductDetailsScreen({this.title, super.key});
  // final title;
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments
        as String; //route = modalroute get data // constructor !=! central state management
    final loadedProduct =
        Provider.of<ProductProvider>(context).findbyId(productId);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title!)),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl!,
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
        ],
      ),
    );
  }
}
