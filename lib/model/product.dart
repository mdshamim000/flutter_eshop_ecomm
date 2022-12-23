import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product with ChangeNotifier {
  String? id;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  bool? isFavorite;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void togglefav() {
    isFavorite = !isFavorite!;
    notifyListeners();
  }
}
