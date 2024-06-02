import 'package:dio/dio.dart';

import 'exceptions.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // var accessToken = await TokenRepository().getAccessToken();
    // options.headers['Authorization'] = 'Bearer $accessToken';
    // options.headers["x-api-key"] = "CUtoAP2R.wsW5aK8odMCJ6nZ6ClMEHsj162OfNlog";

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 204:
            throw NotFoundException(err.requestOptions, err.response!);
          case 403:
          case 400:
            throw BadRequestException(err.requestOptions, err.response!);
          case 401:
            throw UnauthorizedException(err.requestOptions, err.response!);
          case 422:
            throw UnauthorizedException(err.requestOptions, err.response!);
          case 404:
            throw NotFoundException(err.requestOptions, err.response!);
          case 409:
            throw ConflictException(err.requestOptions, err.response!);
          case 500:
            throw InternalServerErrorException(
                err.requestOptions, err.response!);
          case 503:
            throw InternalServerErrorException(
                err.requestOptions, err.response!);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw DioException(
            requestOptions: err.requestOptions,
            message: "Unknown error occured!");
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}
