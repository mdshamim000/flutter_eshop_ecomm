import 'package:flutter/material.dart';
import 'package:flutter_eshop_ecomm/model/product.dart';
import 'package:flutter_eshop_ecomm/provider/carts.dart';
import 'package:flutter_eshop_ecomm/screens/cartscreen.dart';
import 'package:flutter_eshop_ecomm/widgets/app_drawer.dart';
import 'package:flutter_eshop_ecomm/widgets/badge.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, ALL }

class ProductsOverViewScreen extends StatefulWidget {
  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('eSHOP'),
        actions: [
          PopupMenuButton(
            itemBuilder: ((_) => [
                  PopupMenuItem(
                    child: Text('Favorites Only'),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('View All'),
                    value: FilterOptions.ALL,
                  ),
                ]),
            icon: Icon(Icons.more_vert_rounded),
            onSelected: (FilterOptions selvalue) {
              setState(() {
                if (selvalue == FilterOptions.Favorites) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) =>
                Badge(child: ch!, value: cartData.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showFavorites),
    );
  }
}
