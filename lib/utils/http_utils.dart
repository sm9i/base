import 'package:dio/dio.dart';

class HttpUtils {
  const HttpUtils._();

  static final Dio _dio = Dio();

  ///初始化
  static void initConfig(String baseUrl, {BaseOptions options}) {
    ///设置options
    _dio.options = options ??
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: 5000,
          receiveTimeout: 5000,
          sendTimeout: 5000,
        );

    ///设置拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e) {
          print(e);
        },
      ),
    );
  }

  static Future<Map> request(String url, {data, method = 'GET'}) async {
    var result;
    try {
      Response response = await _dio.request(
        url,
        data: data,
        options: Options(
          method: method,
        ),
      );
      result = response.data;
    } catch (e) {
      ///base error
    }
    return result;
  }
}
