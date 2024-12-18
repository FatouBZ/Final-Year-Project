

import 'package:flutter/foundation.dart';
import 'package:multi_store_app/provider/product_class.dart';

class Wish extends ChangeNotifier{
  final List<Product> _list = [];
  List<Product> get getWishItems {
    return _list;
  }

  
  int? get count{
   return _list.length;
  }

  Future<void> addWishItem(
  String name,
  double price,
  int qty,
  int qntty,
  List imageqUrl,
  String documentId,
  String suppId,
  ) async{
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
  
  void removeItem(Product product){
    _list.remove(product);
    notifyListeners();
  }
  void clearWishlist(){
    _list.clear();
    notifyListeners();
  }

 void removeThis(String id){
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }
}