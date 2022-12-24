// import 'package:dartis/dartis.dart';

// class RedisService {
//    //RedisService._();
//   static RedisService _instance = RedisService._();

//   factory RedisService() => _instance;

//   // Variables
//   Client client;
//   Commands commands;

//   init() async {
//     client =
//         await Client.connect('redis://localhost:6379'); // Connection String
//     commands = client.asCommands<String, String>();
//   }

//   disconnect() async {
//     await client.disconnect();
//   }
// }