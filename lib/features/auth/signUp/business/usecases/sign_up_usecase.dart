import 'package:dartz/dartz.dart';
import 'package:m_mart_shopping/core/custom_exception.dart';
import 'package:m_mart_shopping/features/auth/signUp/business/entities/sign_up_entity.dart';
import 'package:m_mart_shopping/features/auth/signUp/business/repositories/sign_up_repository.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';

class SignUpUser {
  final SignUpRepository repository;

  SignUpUser(this.repository);

  Future<Either<CustomException, SignUpEntity>> registerTheUser(
      {required SignUpModel signUpModel}) async {
    return await repository.registerTheUser(signUpModel: signUpModel);
  }
}
