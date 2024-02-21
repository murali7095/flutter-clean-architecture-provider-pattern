import 'package:dartz/dartz.dart';
import 'package:m_mart_shopping/core/custom_exception.dart';
import 'package:m_mart_shopping/features/auth/signUp/business/entities/sign_up_entity.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';

abstract class SignUpRepository {
  Future<Either<CustomException, SignUpEntity>> registerTheUser(
      {required SignUpModel signUpModel});
}
