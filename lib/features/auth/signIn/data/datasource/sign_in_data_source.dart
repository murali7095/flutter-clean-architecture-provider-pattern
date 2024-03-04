import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api services/network/network_api_services.dart';
import '../../../../../core/api services/network/response_handler.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/custom_exception.dart';
import 'package:http/http.dart' as http;

import '../model/sign_in_model.dart';

abstract class SignInDataSource {
  Future<Either<CustomException, http.Response>> loginTheUser(
      {required SignInModel signInModel});
}

class SignInDataSourceImpl implements SignInDataSource {
  @override
  Future<Either<CustomException, http.Response>> loginTheUser(
      {required SignInModel signInModel}) async {
    try {
      final data = {
        "email": signInModel.email,
        "password": signInModel.password,
        "returnSecureToken": signInModel.returnSecureToken
      };
      final payload = json.encode(data);
      final response = await NetworkApiServices()
          .postApiResponse(BaseUrls.signBaseUrl, payload);
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
