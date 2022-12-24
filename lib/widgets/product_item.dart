// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_eshop_ecomm/provider/product_provider.dart';
import 'package:flutter_eshop_ecomm/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';
import '../model/product.dart';
import '../provider/carts.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
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
            productdata.imageUrl,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
          ),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(
                  productdata.isFavorite!
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  product.togglefav(
                    authData.token!,
                    authData.userId!,
                  );
                },
              ),
            ),
            title: Text(productdata.title!)),
        header: Padding(
          padding: const EdgeInsets.only(left: 118.0),
          child: IconButton(
            iconSize: 28,
            icon: Container( 
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black54),
                padding: EdgeInsets.all(2),
                child: Center(child: Icon(Icons.shopping_bag_rounded))),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(
                  productdata.id!, productdata.price!, productdata.title!);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Added to cart',
                ),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removeSingleItem(productdata.id!);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
