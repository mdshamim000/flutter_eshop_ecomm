import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_eshop_ecomm/screens/orderitemview.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersdata = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('MyOrders')),
      body: ListView.builder(
        itemCount: ordersdata.orders.length,
        itemBuilder: (ct, i) => OrderItemView(ordersdata.orders[i]),
      ),
    );
  }
}
