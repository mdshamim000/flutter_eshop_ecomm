import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_eshop_ecomm/provider/orders.dart';
import 'package:intl/intl.dart';

class OrderItemView extends StatefulWidget {
  final OrderItem order;
  OrderItemView(this.order);

  @override
  State<OrderItemView> createState() => _OrderItemViewState();
}

class _OrderItemViewState extends State<OrderItemView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd-MM-yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(isExpanded
                  ? Icons.expand_less_rounded
                  : Icons.expand_circle_down_sharp),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            )),
        isExpanded
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: min(widget.order.products.length * 20 + 20, 180),
                child: ListView(
                    children: widget.order.products
                        .map((p) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    p.title!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${p.quantity}x \$${p.price}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ))
                        .toList()),
              )
            : SizedBox(),
      ]),
    );
  }
}
