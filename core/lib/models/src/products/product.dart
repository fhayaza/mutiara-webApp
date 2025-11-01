import 'dart:convert';

class Product {
  final String? id;
  final String? category;
  final String? grade;
  final String? imageUrl;
  final bool? isAvailable;
  final String? name;
  final int? price;


  Product({
    this.id,
    this.category,
    this.grade,
    this.imageUrl,
    this.isAvailable,
    this.name,
    this.price,

  });

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        id: to<String?>(data['id']),
        category: to<String?>(data['category']),
        grade: to<String?>(data['grade']),
        imageUrl: to<String?>(data['imageUrl']),
        isAvailable: to<bool?>(data['isAvailable']),
        name: to<String?>(data['name']),
        price: to<int?>(data['price']),

      );

  Map<String, dynamic> toMap() => {
        'id': id,        'category': category,        'grade': grade,        'imageUrl': imageUrl,        'isAvailable': isAvailable,        'name': name,        'price': price,
      }..removeWhere(
          (key, value) => value == null,
        );

  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
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
  Product copyWith({String? id,String? category,String? grade,String? imageUrl,bool? isAvailable,String? name,int? price,})=>Product(id:id??this.id,category:category??this.category,grade:grade??this.grade,imageUrl:imageUrl??this.imageUrl,isAvailable:isAvailable??this.isAvailable,name:name??this.name,price:price??this.price,);
}
