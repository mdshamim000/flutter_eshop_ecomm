import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/carts.dart';
import '../provider/orders.dart';
import 'cartItemview.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('MyCart')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: cart.items.length,
              itemBuilder: (itx, i) => CartItemView(
                  id: cart.items.values.toList()[i].id!,
                  productId: cart.items.keys.toList()[i],
                  title: cart.items.values.toList()[i].title!,
                  quantity: cart.items.values.toList()[i].quantity!,
                  price: cart.items.values.toList()[i].price!),
            )),
            SizedBox(
              height: 12,
            ),
            Card(
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(fontSize: 20),
                          ),
                  Spacer(),
                  Chip(
                    label: Text(
                              'Add Coupon',
                            ),
                            backgroundColor: Theme.of(context).accentColor,
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sum Total:',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text('\$${cart.totalCost}'),
                        ]),
                    ElevatedButton(
                        onPressed: (() {
                          Provider.of<Orders>(context, listen: false).addOrder(
                              cart.items.values.toList(), cart.totalCost);

                          cart.clear(); 
                        }),
                        child: Text('Order Now!')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
