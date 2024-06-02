// import 'package:cookie_jar/cookie_jar.dart';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pms/network/api_endpoint.dart';
import 'package:pms/network/app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum METHOD { GET, POST }

class APIService {
  final dio = createDio();

  APIService._internal();

  static final _singleton = APIService._internal();

  factory APIService() => _singleton;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
          baseUrl: ApiEndPoint.kBaseUrl,
          connectTimeout: const Duration(minutes: 2)),
    );

    dio.interceptors.addAll({
      PrettyDioLogger(
        logPrint: (object) => log("$object"),
      ),
      AppInterceptors(Dio(
        BaseOptions(
          baseUrl: ApiEndPoint.kBaseUrl,
        ),
      )),
    });
    return dio;
  }

  Future<Response?> request(String endPoint, METHOD method, data,
      {String? accessToken}) async {
    if (accessToken != null) {
      dio.options.headers['authorization'] = 'Bearer $accessToken';
      log("accesstoken : $accessToken");
    }

    Response? response;
    try {
      switch (method) {
        case METHOD.GET:
          response = await dio.get(endPoint);
          break;
        case METHOD.POST:
          response = await dio.post(endPoint, data: data);
          break;
        default:
      }

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          log('Dio Exception!');
          log('STATUS: ${e.response?.statusCode}');
          log('DATA: ${e.response?.data}');
          log('HEADERS: ${e.response?.headers}');
        }
        // throw e.response?.data;
      } else {
        if (kDebugMode) {
          log('Error sending request!');
          log(e.message.toString());
        }
        // rethrow;
      }
      rethrow;
    }
  }
}
