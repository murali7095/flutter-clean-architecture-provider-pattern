import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m_mart_shopping/core/constants/constants.dart';
import '../../../core/api services/network/network_api_services.dart';
import '../../../core/api services/network/response_handler.dart';
import '../../../core/custom_exception.dart';

abstract class ProductDataSource {
  Future<Either<CustomException, http.Response>> getTheProducts();
}

class ProductDataSourceImpl implements ProductDataSource {
  @override
  Future<Either<CustomException, http.Response>> getTheProducts() async {
    try {
      final response =
          await NetworkApiServices().getApiResponse(BaseUrls.productsBaseUrl);

      var result = responseHandler(response);
      return result.fold((l) {
        return Left(CustomException(
          displayErrorMessage: response.body,
        ));
      }, (r) async {
        return Right(r);
      });
    } catch (e) {
      rethrow;
    }
  }
}
