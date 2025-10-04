import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../config/app_config.dart';

class ApiClient {
  late final Dio _dio;
  
  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      receiveTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 요청 로깅 (디버그 모드에서만)
          if (AppConfig.isDebugMode) {
            print('🚀 API Request: ${options.method} ${options.path}');
            if (options.data != null && AppConfig.logLevel == LogLevel.debug) {
              print('📤 Request Data: ${options.data}');
            }
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          // 응답 로깅 (디버그 모드에서만)
          if (AppConfig.isDebugMode) {
            print('✅ API Response: ${response.statusCode} ${response.requestOptions.path}');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          // 에러 로깅 (항상 기록)
          if (AppConfig.logLevel.index <= LogLevel.error.index) {
            print('❌ API Error: ${error.message}');
            print('📍 Request Path: ${error.requestOptions.path}');
            
            if (error.response != null && AppConfig.isDebugMode) {
              print('📋 Error Data: ${error.response?.data}');
            }
          }
          
          handler.next(error);
        },
      ),
    );
  }

  // GET 요청
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST 요청
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT 요청
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE 요청
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 에러 핸들링
  ApiException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: '연결 시간이 초과되었습니다. 네트워크 상태를 확인해주세요.',
          statusCode: null,
          type: ApiExceptionType.timeout,
        );
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        String message;
        
        switch (statusCode) {
          case 400:
            message = '잘못된 요청입니다.';
            break;
          case 401:
            message = '인증이 필요합니다.';
            break;
          case 403:
            message = '접근이 거부되었습니다.';
            break;
          case 404:
            message = '요청한 리소스를 찾을 수 없습니다.';
            break;
          case 500:
            message = '서버 내부 오류가 발생했습니다.';
            break;
          default:
            message = '서버와의 통신에 문제가 발생했습니다.';
        }
        
        return ApiException(
          message: message,
          statusCode: statusCode,
          type: ApiExceptionType.badResponse,
        );
      
      case DioExceptionType.cancel:
        return ApiException(
          message: '요청이 취소되었습니다.',
          statusCode: null,
          type: ApiExceptionType.cancel,
        );
      
      case DioExceptionType.connectionError:
        return ApiException(
          message: '네트워크 연결을 확인해주세요.',
          statusCode: null,
          type: ApiExceptionType.network,
        );
      
      default:
        return ApiException(
          message: '알 수 없는 오류가 발생했습니다.',
          statusCode: null,
          type: ApiExceptionType.unknown,
        );
    }
  }
}

// API 예외 클래스
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final ApiExceptionType type;

  const ApiException({
    required this.message,
    required this.statusCode,
    required this.type,
  });

  @override
  String toString() => 'ApiException: $message (${statusCode ?? 'N/A'})';
}

enum ApiExceptionType {
  timeout,
  badResponse,
  cancel,
  network,
  unknown,
}

// Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});