import 'dart:convert';

class App {
  final String? qrisImageUrl;
  final String? rekening;
  final String? whatsappNumber;


  App({
    this.qrisImageUrl,
    this.rekening,
    this.whatsappNumber,

  });

  factory App.fromMap(Map<String, dynamic> data) => App(
        qrisImageUrl: to<String?>(data['qrisImageUrl']),
        rekening: to<String?>(data['rekening']),
        whatsappNumber: to<String?>(data['whatsappNumber']),

      );

  Map<String, dynamic> toMap() => {
        'qrisImageUrl': qrisImageUrl,        'rekening': rekening,        'whatsappNumber': whatsappNumber,
      }..removeWhere(
          (key, value) => value == null,
        );

  factory App.fromJson(String data) {
    return App.fromMap(json.decode(data) as Map<String, dynamic>);
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
  App copyWith({String? qrisImageUrl,String? rekening,String? whatsappNumber,})=>App(qrisImageUrl:qrisImageUrl??this.qrisImageUrl,rekening:rekening??this.rekening,whatsappNumber:whatsappNumber??this.whatsappNumber,);
}
