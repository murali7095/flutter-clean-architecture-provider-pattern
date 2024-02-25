import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_exception.dart';
import '../../../../../core/internet connection/network_connection_status.dart';
import '../../business/entities/sign_in_entity.dart';
import '../../business/repositories/sign_in_repository.dart';
import '../datasource/sign_in_data_source.dart';
import '../model/sign_in_model.dart';

class SignInRepositoryImplementation implements SignInRepository {
  @override
  Future<Either<CustomException, SignInEntity>> loginTheUser(
      {required SignInModel signInModel}) async {
    final hasInternetConnection =
        await NetworkInfoImpl(DataConnectionChecker()).isConnected;
    try {
      if (hasInternetConnection) {
        debugPrint("the isConnected: $hasInternetConnection");
        final response =
            await SignInDataSourceImpl().loginTheUser(signInModel: signInModel);
        debugPrint("the SignUpDataSourceImpl: $response");
        return response.fold((l) {
          return Left(
              CustomException(displayErrorMessage: l.displayErrorMessage));
        }, (r) {
          final jsonData = json.decode(r.body);
          return Right(SignInEntity.fromJson(jsonData));
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
