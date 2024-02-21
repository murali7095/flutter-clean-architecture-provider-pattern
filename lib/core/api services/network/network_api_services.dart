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

/*  @override
  Future<Either<CustomException, dynamic>> getApiResponse(String url) async{
    dynamic jsonResponseData;
   try{
     final response =
         await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
     if(response)
     jsonResponseData = jsonResponse(response);

   }catch(e){
     log(e.toString());
   }
  }*/
/*
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
  }*/

  @override
  Future<http.Response> postApiResponse(String url, data) async {
    final http.Response postApiResponseData;
    try {
      postApiResponseData = await http.post(
          Uri.parse(
            url,
          ),
          body: data);
      debugPrint("success");

      return postApiResponseData;
    } catch (e) {
      debugPrint("Exception occurred");
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
