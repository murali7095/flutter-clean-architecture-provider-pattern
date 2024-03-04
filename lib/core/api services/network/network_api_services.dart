import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/api%20services/api_exceptions/api_exceptions.dart';
import 'package:m_mart_shopping/core/api%20services/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:m_mart_shopping/core/custom_exception.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<http.Response> getApiResponse(String url) async {
    final http.Response getApiResponseData;
    try {
      getApiResponseData = await http.get(
        Uri.parse(
          url,
        ),
      );

      return getApiResponseData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> postApiResponse(String url, data) async {
    final http.Response postApiResponseData;
    try {
      postApiResponseData = await http.post(
          Uri.parse(
            url,
          ),
          body: data);

      return postApiResponseData;
    } catch (e) {
      rethrow;
    }
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
