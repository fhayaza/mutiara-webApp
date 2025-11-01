import 'dart:convert';

class LoginRes {
  final String? token;
  final String? type;


  LoginRes({
    this.token,
    this.type,

  });

  factory LoginRes.fromMap(Map<String, dynamic> data) => LoginRes(
        token: to<String?>(data['token']),
        type: to<String?>(data['type']),

      );

  Map<String, dynamic> toMap() => {
        'token': token,        'type': type,
      }..removeWhere(
          (key, value) => value == null,
        );

  factory LoginRes.fromJson(String data) {
    return LoginRes.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
  String toQuery() {
    final tempMap = toMap();
    final length = tempMap.entries.length;
    if (length > 0) {
      return "?${tempMap.entries.map((e) => "${e.key}=${e.value}").join("&")}";
    }
    return "";
  }
  String toParam() => toMap().entries.map((e) => "${e.value}").join("/");
  static T? to<T>(dynamic value) {
    if (value is T) {
      return value;
    }
    return null;
  }
  LoginRes copyWith({String? token,String? type,})=>LoginRes(token:token??this.token,type:type??this.type,);
}
