import 'package:flutter/material.dart';
import 'package:redis/redis.dart';


class RedisPage extends StatefulWidget {
  const RedisPage({super.key});

  @override
  State<RedisPage> createState() => _RedisPageState();
}
class _RedisPageState extends State<RedisPage> {
  late final client;
  late final commands;
  String readValue = '';
  bool isInt = false;
  @override
  initState() {
    intConn();
    super.initState();
  }
 
  Future<void> setRedis() async {
    await client.set('key01', 'B.A.');
  }

  intConn() async {
       //final client = await RedisClient.connect('localhost');
    return isInt = false;
  }

  Future<void> getRedis() async {
  await client.get('key01');

  }

  Future<void> intRedis() async {
    //client = 
        //final result = await commands.ping();
                  //   print("#####$result");
  
  }

  //await client.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 300,
      child: Center(
        child: Column(
          children: [
            Text('Redis Status: $isInt'),
            Text(readValue),
            Text(readValue),
            ElevatedButton(
                onPressed: (() async {
                  intRedis();
                
                }),
                child: Text('intRedis')),
            ElevatedButton(
                onPressed: (() {
                  setRedis();
                }),
                child: Text('SetRedis')),
            ElevatedButton(
                onPressed: (() {
                  getRedis();
                }),
                child: Text('GetRedis')),
          ],
        ),
      ),
    ));
  }
}
