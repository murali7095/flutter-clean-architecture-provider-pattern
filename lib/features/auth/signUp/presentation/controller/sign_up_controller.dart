import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m_mart_shopping/features/auth/signUp/business/usecases/sign_up_usecase.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/repositories/sign_up_repo_impl.dart';

class SignUpController with ChangeNotifier {
  String errorMessage = '';
  bool isLoading = false;
  bool isBack = false;

  Future<void> signUpUserController(
      SignUpModel signUpModel, BuildContext contextMain) async {
    isLoading = true;
    notifyListeners();
    final data = await SignUpUser(SignUpRepositoryImplementation())
        .registerTheUser(signUpModel: signUpModel);
    data.fold((l) {
      var errorResponse = jsonDecode(l.displayErrorMessage);
      String error = errorResponse['error']['message'];
      if (error.contains('EMAIL_EXISTS')) {
        errorMessage =
            ' The email address is already in use by another account';
      } else if (error.contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessage =
            'We have blocked all requests from this device due to unusual activity. Try again later';
      }
      _showErrorDialog(errorMessage, contextMain);
    }, (r) {
      debugPrint('final data : ${r.idToken}');
    });
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
