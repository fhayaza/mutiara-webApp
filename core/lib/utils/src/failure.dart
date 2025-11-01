import 'package:core/core.dart';

class Failure<T> {
  BaseResponse<T> response;
  Failure({
    required this.response,
  });
}
