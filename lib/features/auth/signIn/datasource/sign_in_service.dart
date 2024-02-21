import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m_mart_shopping/core/constants/constants.dart';

import 'dart:developer';

import 'package:m_mart_shopping/features/auth/signIn/datasource/model/signIn_response_model.dart';
import 'package:m_mart_shopping/features/auth/signIn/domain/sign_in_request_model.dart';

class SignInService {
  Future<http.Response?> signInUser(
      SignInRequestModel signInRequestModel) async {
    http.Response? response;
    try {
      var payload = {
        'email': signInRequestModel.email,
        'password': signInRequestModel.password,
      };
      var jsonData = json.encode(payload);
      var apiKey = 'AIzaSyAmdttJwLoYd3udbpr-zh1wlGvU3UKe1CA';
      response = await http.post(Uri.parse(BaseUrls.signBaseUrl + apiKey),
          body: jsonData);
      debugPrint('Sign response ${response.body}');
      if (response.statusCode == 200) {
        var signInResponseModel =
            SignInResponseModel.fromJson(json.decode(response.body));
        debugPrint('Sign in idToken: ${signInResponseModel.idToken}');
      }
    } catch (e) {
      log('Sign in Exception : ${Exception(e)}');
    }
    return response;
  }
}
