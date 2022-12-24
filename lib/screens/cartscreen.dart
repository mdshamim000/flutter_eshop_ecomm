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
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItemView(
                id: cart.items.values.toList()[i].id!,
                productId: cart.items.keys.toList()[i],
                price: cart.items.values.toList()[i].price!,
                quantity: cart.items.values.toList()[i].quantity!,
                title: cart.items.values.toList()[i].title!,
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        '\$${cart.totalCost.toStringAsFixed(2)}',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Discounts',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          'Add Coupon',
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sum Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          '\$${cart.totalCost.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: (() {
                        showDialog(
                            context: context,
                            builder: ((ct) => AlertDialog(
                                  title: Text('Billing'),
                                  content: Container(
                                    height: 233,
                                    child: Column(
                                      children: [
                                        Text('Confirm payment and order'),
                                        Text(
                                          'StripeDEMO',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    OrderButton(cart: cart),
                                    ElevatedButton(
                                        onPressed: (() {
                                          Navigator.of(ct).pop(false);
                                        }),
                                        child: Text('No')),
                                  ],
                                )));
                      }),
                      child: Text('Pay & Order')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Confirm'),
      onPressed: (widget.cart.totalCost <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalCost,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
    );
  }
}
