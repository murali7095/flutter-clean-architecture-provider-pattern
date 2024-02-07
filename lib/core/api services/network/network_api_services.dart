import 'dart:convert';
import 'dart:io';

import 'package:m_mart_shopping/core/api%20services/api_exceptions/api_exceptions.dart';
import 'package:m_mart_shopping/core/api%20services/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic jsonResponseData;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsonResponseData = jsonResponse(response);
    } on SocketException {
      throw InternetException("No Internet, Please try again");
    }
    return jsonResponseData;
  }

  @override
  Future postApiResponse(String url, data) async {
    dynamic jsonResponseData;
    try {
      final response = await http.post(
          Uri.parse(
            url,
          ),
          body: data);
      jsonResponseData = jsonResponse(response);
    } on SocketException {
      throw InternetException("No Internet, Please try again");
    }
    return jsonResponseData;
  }

  dynamic jsonResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException("It's a bad request");
      default:
        throw InternetException(
            "${response.statusCode} : ${response.reasonPhrase}");
    }
  }
}
