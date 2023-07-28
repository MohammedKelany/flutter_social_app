import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    Map<String, dynamic>? query,
    required String url,
    String lang = 'en',
    String? authorization,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": authorization,
      "lang": lang,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    Map<String, dynamic>? query,
    required String url,
    required data,
    String lang = 'en',
    String? authorization,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": authorization,
      "lang": lang,
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    Map<String, dynamic>? query,
    required String url,
    required data,
    String lang = 'en',
    String? authorization,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": authorization,
      "lang": lang,
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
