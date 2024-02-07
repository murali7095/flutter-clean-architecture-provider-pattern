import 'dart:io';

import 'package:m_mart_shopping/core/errors/error_messages.dart';

class CustomException {
  final String displayErrorMessage;

  CustomException({required this.displayErrorMessage});

  CustomException errorResponse(errorType) {
    return errorType;
  }
}

class NoInternetException extends CustomException {
  NoInternetException({required super.displayErrorMessage});

  @override
  CustomException errorResponse(errorType) {
    if (errorType is SocketException) {
      return NoInternetException(
          displayErrorMessage: DisplayErrorMessage.connectivityIssue);
    }
    return CustomException(displayErrorMessage: '');
  }
}

class NoServiceFoundException extends CustomException {
  NoServiceFoundException({required super.displayErrorMessage});

  @override
  CustomException errorResponse(errorType) {
    if (errorType is SocketException) {
      return NoServiceFoundException(
          displayErrorMessage: DisplayErrorMessage.apiDifficulty);
    }
    return CustomException(displayErrorMessage: '');
  }
}

class InvalidFormatException extends CustomException {
  InvalidFormatException({required super.displayErrorMessage});

  @override
  CustomException errorResponse(errorType) {
    if (errorType is SocketException) {
      return InvalidFormatException(
          displayErrorMessage: DisplayErrorMessage.apiDifficulty);
    }
    return CustomException(displayErrorMessage: '');
  }
}
