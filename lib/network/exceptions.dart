import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r, Response<dynamic> re)
      : super(requestOptions: r, response: re);

  @override
  String toString() {
    Map err = response?.data;
    return err['message'].toString();
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r, Response<dynamic> re)
      : super(requestOptions: r, response: re);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r, Response<dynamic> re)
      : super(requestOptions: r, response: re);

  @override
  String toString() {
    Map err = response?.data;
    return err['message'].toString();

    // return '${response?.data["error"] is List && response?.data["error"].isNotEmpty ? response?.data["error"][0] : response?.data["error"]}';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r, Response<dynamic> re)
      : super(requestOptions: r, response: re);

  @override
  String toString() {
    Map err = response?.data;
    return err['message'].toString();
    // return '${response?.data["error"] is List && response?.data["error"].isNotEmpty ? response?.data["error"][0] : response?.data["error"]}';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r, Response<dynamic> re)
      : super(requestOptions: r, response: re);

  @override
  String toString() {
    Map err = response?.data;
    return err['message'].toString();
    // return '${response?.data["error"] is List && response?.data["error"].isNotEmpty ? response?.data["error"][0] : response?.data["error"]}';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
