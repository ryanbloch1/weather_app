import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioProvider {
  Dio dio() {
    final dio = Dio();
    return dio;
  }
}
