class BaseRequest<T> {
  T? data;
  Map<String, dynamic>? params;
  BaseRequest({this.data, this.params});
}
