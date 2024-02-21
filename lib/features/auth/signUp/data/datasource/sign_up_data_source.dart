import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:m_mart_shopping/core/api%20services/network/network_api_services.dart';
import 'package:m_mart_shopping/core/api%20services/network/response_handler.dart';
import 'package:m_mart_shopping/core/constants/constants.dart';
import 'package:m_mart_shopping/core/custom_exception.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';

abstract class SignUpDataSource {
  Future<Either<CustomException, http.Response>> registerTheUser(
      {required SignUpModel signUpModel});
}

class SignUpDataSourceImpl implements SignUpDataSource {
  @override
  Future<Either<CustomException, http.Response>> registerTheUser(
      {required SignUpModel signUpModel}) async {
    try {
      final data = {
        "email": signUpModel.email,
        "password": signUpModel.password,
        "returnSecureToken": signUpModel.returnSecureToken
      };
      final payload = json.encode(data);
      debugPrint("signUpModel.email: ${signUpModel.email}");
      final response = await NetworkApiServices()
          .postApiResponse(BaseUrls.signUpBaseUrl, payload);
      debugPrint("response body: ${response.body}");
      var result = responseHandler(response);
      return result.fold((l) {
        debugPrint("left reached ${jsonDecode(response.body)}");
        return Left(CustomException(
          displayErrorMessage: response.body,
        ));
      }, (r) {
        debugPrint("right reached");
        return Right(r);
      });
    } catch (e) {
      debugPrint("cache reached");
      rethrow;
    }
  }
}
