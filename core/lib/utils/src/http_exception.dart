import 'package:dio/dio.dart';

class HttpException {
  Response response;
  HttpException({
    required this.response,
  });
}
