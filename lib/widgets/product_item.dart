// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_eshop_ecomm/provider/product_provider.dart';
import 'package:flutter_eshop_ecomm/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/carts.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productdata = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      //changeshape
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
        child: GestureDetector(
          onTap: (() {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: productdata.id);
          }),
          child: Image.network(
            productdata.imageUrl!,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
          ),
        ),
        footer: GridTileBar(
            leading: IconButton(
              icon: Icon(
                productdata.isFavorite!
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                productdata.togglefav();
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_bag_outlined),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(
                    productdata.id!, productdata.price!, productdata.title!);
              },
            ),
            backgroundColor: Colors.black87,
            title: Text(productdata.title!)),
      ),
    );
  }
}
