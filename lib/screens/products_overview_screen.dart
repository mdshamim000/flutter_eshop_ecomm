import 'package:flutter/material.dart'; 
import 'package:flutter_eshop_ecomm/model/product.dart';
import 'package:flutter_eshop_ecomm/provider/carts.dart';
import 'package:flutter_eshop_ecomm/provider/product_provider.dart';
import 'package:flutter_eshop_ecomm/redis/redis_page.dart';
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
  var _isInit = true;
  var _isLoading = false;
  bool _showFavorites = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
            icon: Icon(Icons.favorite),
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
              iconSize: 23,
              icon: Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: 800,
              child: Column(
                children: [ 
                  Expanded(child: ProductsGrid(_showFavorites)),
                ],
              ),
            ),
    );
  }
}
