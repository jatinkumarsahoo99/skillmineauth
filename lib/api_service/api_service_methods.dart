import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as service;

class ApiService {
  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() {
    return _instance;
  }

  static Dio dio = Dio();

  Map<String, dynamic> failedMap = {
    "status": "failed",
    "message": "error",
  };

  getMethodCall({required String api, required Function fun}) async {
    if (kDebugMode) {
      print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n$api");
    }
    try {
      Response response = await dio.get(api);
      if (response.statusCode == 200) {
        try {
          fun(response.data);
        } catch (e) {
          if (kDebugMode) {
            print("Message is: $e");
          }
        }
      } else {
        fun(failedMap);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Message is: $e");
      }
      fun(failedMap);
    }
  }

  postMethodCall({required String api, dynamic json, required Function fun}) async {
    try {
      if (kDebugMode) {
        print("API NAME:>$api");
      }
      service.Response response = await dio.post(
        api,
        data: (json != null) ? jsonEncode(json) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          if (kDebugMode) {
            print("Message is: $e");
          }
        }
      } else if (response.statusCode == 417) {
        fun(response.data);
      } else {
        if (kDebugMode) {
          print("Message is: >>1");
        }
        fun(failedMap);
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioException.requestCancelled:
        case DioException.sendTimeout:
        case DioException.connectionTimeout:
        case DioException.receiveTimeout:
          fun(failedMap);
          break;
        case DioException.badResponse:
          fun(e.response?.data);
          break;
        default:
          fun(failedMap);
          break;
      }
    }
  }
}
