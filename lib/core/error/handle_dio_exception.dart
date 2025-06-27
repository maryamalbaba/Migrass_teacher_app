import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teacher/core/error/Error_model.dart';

void HandleDioException(DioException e) {
  debugPrint("DIO ERROR => ${e.type}, message: ${e.message}");

  if (e.response != null) {
    debugPrint("STATUS CODE => ${e.response?.statusCode}");
    debugPrint("RESPONSE DATA => ${e.response?.data}");
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.connectionError:
      throw ErrorModel(message: "الرجاء التحقق من اتصال الإنترنت");

    case DioExceptionType.cancel:
      throw ErrorModel(message: "تم إلغاء الطلب");

    case DioExceptionType.unknown:
      throw ErrorModel(message: "حدث خطأ غير معروف");

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final serverMessage = e.response?.data?['message'] ?? "خطأ غير معروف";

      if (statusCode == 401) {
        throw ErrorModel(message: "غير مصرح");
      } else if (statusCode == 404) {
        throw ErrorModel(message: "العنصر غير موجود");
      } else if (statusCode == 500) {
        throw ErrorModel(message: "خطأ في الخادم");
      }

      throw ErrorModel(message: serverMessage);

    default:
      throw ErrorModel(message: "حدث خطأ أثناء الاتصال");
  }
}
