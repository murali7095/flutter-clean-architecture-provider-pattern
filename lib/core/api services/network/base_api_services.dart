import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:m_mart_shopping/core/custom_exception.dart';

abstract class BaseApiServices {
  Future<dynamic> getApiResponse(String url);

  Future<http.Response> postApiResponse(String url, dynamic data);
}
