// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../provider/carts.dart';

class CartItemView extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  const CartItemView({
    Key? key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 42,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text("Quantity: $quantity"),
          ),
        ),
      ),
    );
  }
}
