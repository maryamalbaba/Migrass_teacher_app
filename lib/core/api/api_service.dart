import 'dart:async';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/resource/api_manager.dart';

import '../enums/api_method.dart';
import '../resource/navigator_manager.dart';
import '../resource/route_const.dart';
class ApiService {
  static ApiService? _instance;
  late dio.Dio _dio;
  late dio.BaseOptions options;

  ApiService._() {
    options = dio.BaseOptions(
      baseUrl: ApiManager.baseUrl,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: getHeaders,
      validateStatus: (status) => (status ?? double.infinity) <= 500,
    );
    _dio = dio.Dio(options);

    if (!kReleaseMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
      _dio.interceptors.add(CurlLoggerDioInterceptor());
    }
  }

  static ApiService get instance {
    _instance ??= ApiService._();
    return _instance!;
  }

  get getHeaders =>
      {
        'Content-Type': 'application/json',
        "Accept": "application/json",
        // "version": AppConstants.appVersion,
        // "Accept-Language": HiveManager.instance.getString(HiveUserKeys.lang) ?? "ar",
        // "company-id": AppConstants.apiConstants.companyId,
        "Authorization": "Bearer ${SharedPreferencesManger.instance.getString(
            SharedPreferencesKeys.token)}",
      };

  Future<bool> _checkInternetConnection() async => true;

  Future<Either<String?, dynamic>> makeRequestMultiPart({
    required ApiMethod method,
    required String endPoint,
    dio.FormData? formData,
    Map<String, dynamic>? headers,
    bool showSnackBarOnError = true,
  }) async {
    bool isConnected = await _checkInternetConnection();
    if (!isConnected) {
      return const Left("الرجاء التحقق من اتصالك بالإنترنت.");
    }

    _dio.options = _dio.options.copyWith(method: method.value);
    _dio.options.headers = getHeaders;
    _dio.options.headers.addAll({'Content-Type': "multipart/form-data"});
    if (headers != null) _dio.options.headers.addAll(headers);

    try {
      final response = await _dio.request(endPoint, data: formData);
      final apiResponse = handleApiError(response, showSnackBarOnError);
      return apiResponse.status == ApiResponseStatus.failure
          ? Left(apiResponse.message)
          : Right(apiResponse.data);
    } catch (e) {
      return Left("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا.");
    }
  }

  Future<Either<String?, dynamic>> makeRequest({
    required ApiMethod method,
    required String endPoint,
    Map<String, dynamic>? body,
    dio.FormData? formData,
    Map<String, dynamic>? headers,
    bool showSnackBarOnError = true,
  }) async {
    bool isConnected = await _checkInternetConnection();
    if (!isConnected) {
      return Left("الرجاء التحقق من اتصالك بالإنترنت.");
    }

    _dio.options = _dio.options.copyWith(method: method.value);
    _dio.options.headers = getHeaders;
    if (headers != null) _dio.options.headers.addAll(headers);

    try {
      final response = await _dio.request(endPoint, data: formData ?? body);
      final apiResponse = handleApiError(response, showSnackBarOnError);
      return apiResponse.status == ApiResponseStatus.failure
          ? Left(apiResponse.message)
          : Right(apiResponse.data);
    } catch (e) {
      return Left("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا.");
    }
  }

  ApiResponse handleApiError(dynamic error, bool showSnackBarOnError) {
    if (error is dio.DioError) {
      switch (error.type) {
        case dio.DioErrorType.connectionTimeout:
        case dio.DioErrorType.sendTimeout:
        case dio.DioErrorType.receiveTimeout:
          return ApiResponse.failure(
              "انتهت مهلة الاتصال، يرجى المحاولة لاحقًا.");
        case dio.DioErrorType.badResponse:
          return _handleResponseError(error.response, showSnackBarOnError);
        case dio.DioErrorType.cancel:
          return ApiResponse.failure("تم إلغاء الطلب.");
        case dio.DioErrorType.unknown:
          return ApiResponse.failure(
              "خطأ في الاتصال، يرجى التحقق من اتصالك بالإنترنت.");
        default:
          return ApiResponse.failure("خطأ غير معروف.");
      }
    } else if (error is dio.Response) {
      return _handleResponseError(error, showSnackBarOnError);
    } else {
      return ApiResponse.failure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا.");
    }
  }

  ApiResponse _handleResponseError(dio.Response? response,
      bool showSnackBarOnError) {
    if (response == null) {
      return ApiResponse.failure("حدث خطأ غير متوقع، يرجى المحاولة لاحقًا.");
    }

    switch (response.statusCode) {
      case 200:
        return ApiResponse.success(response.data);
      case 201:
        return ApiResponse.success(response.data);
      case 203:
        return ApiResponse.success(response.data);
      case 400:
        return ApiResponse.failure(response.data['message'] ?? "طلب غير صالح.");
      case 401:
        AppNavigator.instance.pushReplacementAll(name: RouteConst.login);
        return ApiResponse.failure(response.data['message']);
      case 422:
        return ApiResponse.failure(response.data['message']);
      case 403:
        return ApiResponse.failure("ليس لديك إذن للوصول إلى هذا المورد.");
      case 404:
        return ApiResponse.failure("تعذر العثور على المورد المطلوب.");
      case 405:
        return ApiResponse.failure("طريقة الطلب غير مسموح بها.");
      case 500:
        return ApiResponse.failure("حدث خطأ في الخادم، يرجى المحاولة لاحقًا.");
      default:
        return ApiResponse.failure("حدث خطأ في الخادم، يرجى المحاولة لاحقًا.");
    }
  }
}

class ApiResponse {
  final ApiResponseStatus status;
  final dynamic data;
  final String? message;

  ApiResponse.success(this.data)
      : status = ApiResponseStatus.success,
        message = null;

  ApiResponse.failure(this.message)
      : status = ApiResponseStatus.failure,
        data = null;
}

enum ApiResponseStatus { success, failure }