import 'package:dio/dio.dart' hide Headers;
import 'package:vitremit/network/expection/api_exception.dart';
import 'package:vitremit/network/handlers/response_handler.dart';

class RestClient {
  ///static const String _contentTypeHeader = 'content-type';
  // static const String _contentLength = 'content-length';
  // static const String _authorizationHeader = 'Authorization';

  static const String _connectionErrorMessage = 'Network Problem';


  // dio instance
  Dio get _dio {
    final dio = Dio(BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'Basic eGJwLXBhcnRuZXItdG9rZW46UFY2RVhYOVdWM05ZQTNHNEVZNk1CT05NTE5CNENMMkc='
        // 'Authorization':'Basic PV6EXX9WV3NYA3G4EY6MBONMLNB4CL2G'
      },
    ));
    return dio;
  }

  Dio get _dio2 {
    final dio = Dio(BaseOptions(
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    return dio;
  }

  // instance of class singleton
  static final RestClient _singleton = RestClient._internal();
  RestClient._internal();
  factory RestClient() => _singleton;

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          validateStatus: (_) => true,
        ),
      );
      return responseHandler(response);
    } on DioError catch (_) {
      throw const FetchDataException(_connectionErrorMessage);
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    dynamic headers,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          validateStatus: (_) => true,
        ),
      );
      return responseHandler(response);
    } on DioError catch (_) {
      throw const FetchDataException(_connectionErrorMessage);
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> postWithHeader(
    String uri, {
    dynamic headers,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio2.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (_) => true,
        ),
      );
      return responseHandler(response);
    } on DioError catch (_) {
      throw const FetchDataException(_connectionErrorMessage);
    }
  }
}
