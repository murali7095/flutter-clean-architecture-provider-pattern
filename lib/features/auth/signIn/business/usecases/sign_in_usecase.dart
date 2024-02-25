import 'package:dartz/dartz.dart';

import '../../../../../core/custom_exception.dart';
import '../../data/model/sign_in_model.dart';
import '../entities/sign_in_entity.dart';
import '../repositories/sign_in_repository.dart';

class SignInUser {
  final SignInRepository repository;

  SignInUser(this.repository);

  Future<Either<CustomException, SignInEntity>> loginTheUser(
      {required SignInModel signInModel}) async {
    return await repository.loginTheUser(signInModel: signInModel);
  }
}
