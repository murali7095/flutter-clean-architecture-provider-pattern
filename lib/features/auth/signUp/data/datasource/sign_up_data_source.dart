import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

      final response = await NetworkApiServices()
          .postApiResponse(BaseUrls.signUpBaseUrl, payload);

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
