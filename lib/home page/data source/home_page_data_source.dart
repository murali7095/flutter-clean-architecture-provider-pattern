import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:m_mart_shopping/products/product_model.dart';

class HomePageDataSource {
  Future<List<Product>?> getTheAllProducts() async {
    List<Product>? product;
    debugPrint("before try");
    try {
      var response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      debugPrint("theresponse: $response");
      if (response.statusCode == 200) {
        // var josnObjects= json.decode(response.body);
        //    debugPrint("josnObjects: $josnObjects");
        product = producModelFromJson(response.body);
        debugPrint("the perduct title: ${product[0].title}");
      }
      //return
    } catch (e) {
      print('error : $e ');
      // log('something went wrong');
    }
    return product;
  }
}
