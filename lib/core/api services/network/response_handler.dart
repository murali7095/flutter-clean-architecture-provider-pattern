import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../api_exceptions/api_exceptions.dart';

Either<AppExceptions, http.Response> responseHandler(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return Right(response);
    case 400:
      return Left(AppExceptions('400 Exception ${response.body}'));
    case 401:
      return Left(AppExceptions('401 Exception ${response.body}'));
    case 404:
      return Left(AppExceptions('404 Exception ${response.body}'));
    case 500:
      return Left(AppExceptions('500 Exception ${response.body}'));
    default:
      return Left(AppExceptions('Other Exception ${response.body}'));
  }
}
