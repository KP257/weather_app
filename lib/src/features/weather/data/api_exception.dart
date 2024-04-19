import 'dart:io';

sealed class APIException implements Exception {
  APIException(this.message);

  final String message;
}

class InvalidApiKeyException extends APIException {
  InvalidApiKeyException() : super('Invalid API key');
}

class NoInternetConnectionException extends APIException {
  NoInternetConnectionException() : super('No Internet connection');
}

class CityNotFoundException extends APIException {
  CityNotFoundException() : super('City not found');
}

class UnknownException implements Exception {
  UnknownException();
}

String getErrorMessage(dynamic e) {
  if (e is InvalidApiKeyException ||
      e is NoInternetConnectionException ||
      e is CityNotFoundException ||
      e is UnknownException) {
    return e.message;
  } else if (e is SocketException) {
    return e.message;
  } else {
    return 'An unknown error occurred';
  }
}
