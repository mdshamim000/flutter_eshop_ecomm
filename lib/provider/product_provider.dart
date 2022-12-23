import 'package:flutter/material.dart';
import 'package:flutter_eshop_ecomm/model/product.dart';

class ProductProvider with ChangeNotifier {
  // List<Product> _item = []; 

  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://gw.alicdn.com/bao/uploaded/i4/2211100275674/O1CN018ZG1Ji1rmk3yihSVI_!!0-item_pic.jpg_300x300q90.jpg_.webp',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://gw.alicdn.com/bao/uploaded/i3/2294379577/O1CN01DPjbp02KcJtqSyvEl_!!2294379577.png_300x300q90.jpg_.webp',
    ),
    Product(
      id: 'p3',
      title: 'Winter Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://gw.alicdn.com/bao/uploaded/i2/2261059285/O1CN016cBWJD2ISaC2gaZWM_!!0-item_pic.jpg_300x300q90.jpg_.webp',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://gw.alicdn.com/bao/uploaded/i2/3166080722/O1CN01cqnVww1HCiZm7Rbg1_!!3166080722.jpg_300x300q90.jpg_.webp',
    ),
    Product(
      id: 'p5',
      title: 'Matte Cap',
      description: 'Material Jeans Cap.',
      price: 49.99,
      imageUrl:
          'https://gw.alicdn.com/bao/uploaded/i2/2750302092/O1CN01SsNynh1RKBCcDruA2_!!2750302092.jpg_300x300q90.jpg_.webp',
    ),
    Product(
      id: 'p6',
      title: 'Leenzr Jacket',
      description: 'Winter jacket',
      price: 49.99,
      imageUrl:
          'https://gw.alicdn.com/bao/uploaded/i4/2206665971253/O1CN01HNW43e1L7v47TtqOO_!!2206665971253.jpg_300x300q90.jpg_.webp',
    ),
  ];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favitems {
    return _items.where((e) => e.isFavorite!).toList();
  }

  Product findbyId(String id) {
    return _items.firstWhere((e) => e.id == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
