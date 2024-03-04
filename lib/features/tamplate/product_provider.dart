import 'package:flutter/cupertino.dart';
import 'package:m_mart_shopping/features/home%20page/data%20source/home_page_data_source.dart';
import 'package:m_mart_shopping/features/products/product_model.dart';

class ProductProvider extends ChangeNotifier {
  var source = HomePageDataSource();
  List<Product>? products;
  bool isLoading = false;

  void getProducts() async {
    isLoading = true;
    products = (await source.getTheAllProducts());
    isLoading = false;
    notifyListeners();
  }
}
