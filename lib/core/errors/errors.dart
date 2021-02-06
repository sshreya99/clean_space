import 'package:clean_space/core/errors/failures.dart';

class Error extends Failure {
  Error({message}) : super(message: message);
}

class InputError extends Error {
  InputError({message}) : super(message: message);
}

class NetworkError extends Error {
  NetworkError({message}) : super(message: message);
}
class AuthError extends Error {
  AuthError({message}) : super(message: message);
}