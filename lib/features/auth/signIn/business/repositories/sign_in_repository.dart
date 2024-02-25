import 'package:dartz/dartz.dart';

import '../../../../../core/custom_exception.dart';
import '../../data/model/sign_in_model.dart';
import '../entities/sign_in_entity.dart';

abstract class SignInRepository {
  Future<Either<CustomException, SignInEntity>> loginTheUser(
      {required SignInModel signInModel});
}
