import 'dart:convert';

import 'package:flutter/material.dart';

import '../../business/usecases/sign_in_usecase.dart';
import '../../data/model/sign_in_model.dart';
import '../../data/repositories/sign_in_repo_impl.dart';

class SignInController with ChangeNotifier {
  String errorMessage = '';
  bool isLoading = false;
  bool isBack = false;

  Future<void> signInUserController(
      SignInModel signInModel, BuildContext contextMain) async {
    isLoading = true;
    isBack = false;
    notifyListeners();
    final data = await SignInUser(SignInRepositoryImplementation())
        .loginTheUser(signInModel: signInModel);
    data.fold((l) {
      var errorResponse = jsonDecode(l.displayErrorMessage);
      String error = errorResponse['error']['message'];
      if (error.contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Please enter correct email';
      } else if (error.contains('INVALID_PASSWORD')) {
        errorMessage = 'Please enter correct password';
      }
      _showErrorDialog(errorMessage, contextMain);
    }, (r) {
      isBack = true;
    });
    isLoading = false;
    notifyListeners();
  }

  void _showErrorDialog(String errorMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alert!'),
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
