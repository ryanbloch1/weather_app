import 'package:dio/dio.dart';
import 'package:weather_app/domain/models/core_failures/abstract_core_failure.dart';

class ApiFailure implements CoreFailure {
  final String? message;
  final int? code;

  ApiFailure._({this.message, this.code});

  static ApiFailure unauthorized() => ApiFailure._(
    code: 401, 
    message: "Unauthorized: API key missing, not activated, incorrect, or insufficient permissions."
  );

  static ApiFailure notFound() => ApiFailure._(
    code: 404, 
    message: "Not Found: Incorrect city name, ZIP-code, city ID, or request format."
  );

  static ApiFailure tooManyRequests() => ApiFailure._(
    code: 429, 
    message: "Too Many Requests: API call limit exceeded for your subscription level."
  );

  static ApiFailure serverError() => ApiFailure._(
    code: 500, 
    message: "Server Error: Please contact support with your API request for further assistance."
  );

  static ApiFailure fromDioError(DioException error) {
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 401:
          return unauthorized();
        case 404:
          return notFound();
        case 429:
          return tooManyRequests();
        case 500:
        case 502:
        case 503:
        case 504:
          return serverError();
        default:
          return ApiFailure._(code: error.response!.statusCode, message: "Unhandled Error");
      }
    } else {
      return ApiFailure._(message: "No Response: ${error.message}");
    }
  }

  static ApiFailure general({String? message}) => ApiFailure._(
    code: null, 
    message: message ?? "General Error: An unexpected error occurred."
  );
}
