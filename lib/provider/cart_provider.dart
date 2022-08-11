

import 'package:flutter/foundation.dart';

import 'product_class.dart';

class Cart extends ChangeNotifier{
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  double get totalPrice{
    var total = 0.0;
    for(var item in _list){
      total +=item.price * item.qty;
    }
    return total;
  }
  int? get count{
   return _list.length;
  }

  void addItem(
  String name,
  double price,
  int qty,
  int qntty,
  List imageqUrl,
  String documentId,
  String suppId,
  ){
    final product = Product(
      name: name, 
      price: price,
      qty: qty,
      qntty: qntty, 
      imageqUrl: imageqUrl, 
      documentId: documentId,
      suppId: suppId);
      _list.add(product);
      notifyListeners();
  }
  void increment (Product product){
    product.increase();
    notifyListeners();
  }
   void reduceByOne (Product product){
    product.decrase();
    notifyListeners();
  }
  void removeItem(Product product){
    _list.remove(product);
    notifyListeners();
  }
  void clearCart(){
    _list.clear();
    notifyListeners();
  }

  
}