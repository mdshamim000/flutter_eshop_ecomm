import 'package:flutter/material.dart';
import 'package:flutter_eshop_ecomm/auth/auth_screen.dart';
import 'package:flutter_eshop_ecomm/provider/carts.dart';
import 'package:flutter_eshop_ecomm/provider/orders.dart';
import 'package:flutter_eshop_ecomm/provider/product_provider.dart';
import 'package:flutter_eshop_ecomm/screens/cartscreen.dart'; 
import 'package:flutter_eshop_ecomm/screens/orderscreen.dart';
import 'package:flutter_eshop_ecomm/screens/product_details_screen.dart';
import 'package:flutter_eshop_ecomm/screens/products_overview_screen.dart'; 
import 'package:provider/provider.dart';


import 'auth/auth.dart';

Future<void> main() async {
   
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (
            ctx,
          ) =>
              ProductProvider('', '', []),
          update: (ctx, auth, previousProducts) => ProductProvider(
            auth.token??'',
            auth.userId??'' ,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', '', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'e-Shop',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverViewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Center(child: CircularProgressIndicator())
                          : AuthScreen(),
                ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),  
          },
        ),
      ),
    );
  }
}
