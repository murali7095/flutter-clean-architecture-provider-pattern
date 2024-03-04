import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:m_mart_shopping/features/products/product_model.dart';

class HomePageDataSource {
  Future<List<Product>?> getTheAllProducts() async {
    List<Product>? product;

    try {
      var response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        product = producModelFromJson(response.body);
      }
      //return
    } catch (e) {
      print('error : $e ');
      // log('something went wrong');
    }
    return product;
  }
}
