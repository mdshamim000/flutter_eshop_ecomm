import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eshop_ecomm/model/http_exception.dart';
import 'package:flutter_eshop_ecomm/model/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  // List<Product> _item = [];

  List<Product> _items = [];
  // var _showFavoritesOnly = false;
  final String authToken;
  final String userId;

  ProductProvider(this.authToken, this.userId, this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite!).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    // final filterString =
    //     filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        Uri.parse('https://excommerce-97aef.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      url = Uri.parse(
          'https://excommerce-97aef.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      if (favoriteData != null) {
        extractedData.forEach((prodId, prodData) async {
          loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: favoriteResponse.body.contains(prodId) ? true : false,
            imageUrl: prodData['imageUrl'],
          ));
          print('@@1' + favoriteResponse.body.contains(prodId).toString());
        });
      } else {
        extractedData.forEach((prodId, prodData) async {
          loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: false,
            imageUrl: prodData['imageUrl'],
          ));
        });
        print('@@' + favoriteData.toString());
      }

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print('#####' + error.toString());
      //throw HttpException(error.toString());
    }
  }

  // Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
  //   final filterString =
  //       filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
  //   var url = Uri.parse(
  //       'https://excommerce-97aef.firebaseio.com/products.json?auth=$authToken&$filterString');
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData == null) {
  //       return;
  //     }
  //     url = Uri.parse(
  //         'https://excommerce-97aef.firebaseio.com/userFavorites/$userId.json?auth=$authToken');

  //     final favoriteResponse = await http.get(url);
  //     final favoriteData = json.decode(favoriteResponse.body);
  //     final List<Product> loadedProducts = [];
  //     extractedData.forEach((prodId, prodData) {
  //       loadedProducts.add(Product(
  //         id: prodId,
  //         title: prodData['title'],
  //         description: prodData['description'],
  //         price: prodData['price'],
  //         isFavorite:
  //             favoriteData == null ? false : favoriteData[prodId] ?? false,
  //         imageUrl: prodData['imageUrl'],
  //       ));
  //     });
  //     _items = loadedProducts;
  //     notifyListeners();
  //   } catch (error) {
  //     //throw HttpException(error.toString());
  //   }
  // }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://excommerce-97aef.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://excommerce-97aef.firebaseio.com/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      throw HttpException('update failed product.');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://excommerce-97aef.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct == null;
  }

  // void addProduct(Product product) {
  //   final newProduct = Product(
  //     title: product.title,
  //     description: product.description,
  //     price: product.price,
  //     imageUrl: product.imageUrl,
  //     id: DateTime.now().toString(),
  //   );
  //   _items.add(newProduct);
  //   // _items.insert(0, newProduct); // at the start of the list
  //   notifyListeners();
  // }

  // void updateProduct(String id, Product newProduct) {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {}
  // }

  // void deleteProduct(String id) {
  //   _items.removeWhere((prod) => prod.id == id);
  //   notifyListeners();
  // }
}
