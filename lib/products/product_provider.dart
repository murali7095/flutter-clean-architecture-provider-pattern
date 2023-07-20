import 'package:flutter/cupertino.dart';
import 'package:m_mart_shopping/home%20page/data%20source/home_page_data_source.dart';
import 'package:m_mart_shopping/products/product_model.dart';

class ProductProvider extends ChangeNotifier{
  var source = HomePageDataSource();
  List<Product>? products;
  bool isLoading= false;
  void getProducts( ) async{
    isLoading=true;
    products=(await source.getTheAllProducts());
    debugPrint('product ${products?.elementAt(1).title}');
    isLoading=false;
    notifyListeners();
  }
}