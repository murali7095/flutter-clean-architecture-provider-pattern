import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/custom_exception.dart';
import 'package:m_mart_shopping/core/internet%20connection/network_connection_status.dart';
import 'package:m_mart_shopping/features/auth/signUp/business/entities/sign_up_entity.dart';
import 'package:m_mart_shopping/features/auth/signUp/business/repositories/sign_up_repository.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/datasource/sign_up_data_source.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';

class SignUpRepositoryImplementation implements SignUpRepository {
  @override
  Future<Either<CustomException, SignUpEntity>> registerTheUser(
      {required SignUpModel signUpModel}) async {
    final hasInternetConnection =
        await NetworkInfoImpl(DataConnectionChecker()).isConnected;
    try {
      if (hasInternetConnection) {
        debugPrint("the isConnected: $hasInternetConnection");
        final response = await SignUpDataSourceImpl()
            .registerTheUser(signUpModel: signUpModel);
        debugPrint("the SignUpDataSourceImpl: $response");
        return response.fold((l) {
          return Left(
              CustomException(displayErrorMessage: l.displayErrorMessage));
        }, (r) {
          final jsonData = json.decode(r.body);
          return Right(SignUpEntity.fromJson(jsonData));
        });
      } else {
        return Left(NoInternetException(displayErrorMessage: 'No Internet'));
      }
    } catch (e) {
      debugPrint("cache reached");
      rethrow;
    }
  }
}
