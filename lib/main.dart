import 'package:flutter/material.dart';
import 'package:flutter_eshop_ecomm/provider/carts.dart';
import 'package:flutter_eshop_ecomm/provider/orders.dart';
import 'package:flutter_eshop_ecomm/provider/product_provider.dart';
import 'package:flutter_eshop_ecomm/screens/cartscreen.dart';
import 'package:flutter_eshop_ecomm/screens/orderscreen.dart';
import 'package:flutter_eshop_ecomm/screens/product_details_screen.dart';
import 'package:flutter_eshop_ecomm/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(
        //   value: Orders(),
        // ),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter eSHOP',
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato'),
        home: ProductsOverViewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
        },
      ),
    );
  }
}
