import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('eSHOP'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.home_work),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/");
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Payment'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/");
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.pending),
          title: Text('MyOrders'),
          onTap: () {
            Navigator.of(context).pushNamed("/orders");
          },
        ),
      ]),
    );
  }
}
