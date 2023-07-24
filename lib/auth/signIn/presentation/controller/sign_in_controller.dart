import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m_mart_shopping/auth/signIn/datasource/sign_in_service.dart';
import 'package:m_mart_shopping/auth/signIn/domain/sign_in_request_model.dart';
import 'package:http/http.dart' as http;

class SignInController with ChangeNotifier {
  String errorMessage = '';
  bool isLoading = false;
  bool isBack = false;
  final SignInService signInService = SignInService();

  Future<void> signInUserController(
      SignInRequestModel signInRequestModel, BuildContext contextMain) async {
    isLoading = true;
    notifyListeners();
    http.Response response =
        (await signInService.signInUser(signInRequestModel))!;
    if (response.statusCode == 200) {
      isBack = true;
    } else if (response.statusCode == 400) {
      var errorResponse = jsonDecode(response.body);
      String error = errorResponse['error']['message'];
      if (error.contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Email not found, please try with correct Email address';
      } else if (error.contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password, please try with correct password';
      }
      _showErrorDialog(errorMessage, contextMain);
    }
    isLoading = false;
    notifyListeners();
  }

  void _showErrorDialog(String errorMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred'),
        content: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 12),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Ok')),
        ],
      ),
    );
  }
}
