// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:jbeauty/data/shared_perf_manager.dart';

class Product {
  final String name;
  final String image;
  final String price;
  final String description;
  final String? descriptionAr;
  final String? nameAr;
  final double rating;

  // final Category category;

  final String id;
  final List<dynamic>? ingredients;

  final int? quantity;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.descriptionAr,
    this.nameAr,
    required this.rating,
    required this.id,
    required this.ingredients,
    this.quantity = 1,
  });

  String get nameTR {
    return SharedPerfManager.locale.languageCode == 'en'
        ? name
        : (nameAr ?? '');
  }

  String get discrptionTR {
    return SharedPerfManager.locale.languageCode == 'en'
        ? description
        : (descriptionAr ?? '');
  }

  double get total => quantity! * double.parse(price);

  Product copyWith({
    String? name,
    String? image,
    String? price,
    String? descriptionAr,
    String? nameAr,
    String? description,
    double? rating,
    String? id,
    List<dynamic>? ingredients,
    int? quantity,
  }) {
    return Product(
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      id: id ?? this.id,
      ingredients: ingredients ?? this.ingredients,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'name_ar': nameAr,
      'description_ar': descriptionAr,
      'image': image,
      'price': price,
      'description': description,
      'rating': rating,
      'id': id,
      'ingredients': ingredients,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'] as String,
        image: map['image'] as String,
        price: map['price'] as String,
        description: map['description'] as String,
        rating: map['rating'] as double,
        nameAr: map['name_ar'] as String?,
        descriptionAr: map['description_ar'] as String?,
        id: map['id'] as String,
        quantity: map['quantity'] ?? 1,
        ingredients: List<dynamic>.from(
          (map['ingredients'] ?? []),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(name: $name, image: $image, price: $price, description: $description, rating: $rating, id: $id, ingredients: $ingredients)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image == image &&
        other.price == price &&
        other.description == description &&
        other.rating == rating &&
        other.id == id &&
        listEquals(other.ingredients, ingredients);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        description.hashCode ^
        rating.hashCode ^
        id.hashCode ^
        ingredients.hashCode;
  }
}

class Category {
  final String name;
  final String id;
  final String? nameAr;

  String get nameTR {
    return SharedPerfManager.locale.languageCode == 'en'
        ? name
        : (nameAr ?? '');
  }

  Category({
    required this.name,
    this.nameAr,
    required this.id,
  });

  Category copyWith({
    String? name,
    String? nameAr,
    String? id,
  }) {
    return Category(
      name: name ?? this.name,
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'name_ar': nameAr,
      'id': id,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] as String,
      nameAr: map['name_ar'] as String?,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Category(name: $name, id: $id)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}

class SubCategory {
  final String name;
  final String? nameAr;
  final String discrption;
  final String? discrptionAr;
  final String id;
  final double discount;

  SubCategory({
    required this.name,
    required this.discrption,
    required this.id,
    required this.discount,
    this.nameAr,
    this.discrptionAr,
  });

  String get nameTR {
    return SharedPerfManager.locale.languageCode == 'en'
        ? name
        : (nameAr ?? '');
  }

  String get discrptionTR {
    return SharedPerfManager.locale.languageCode == 'en'
        ? discrption
        : (discrptionAr ?? '');
  }

  SubCategory copyWith({
    String? name,
    String? discrption,
    String? id,
    double? discount,
    String? nameAr,
    String? discrptionAr,
  }) {
    return SubCategory(
      name: name ?? this.name,
      discrption: discrption ?? this.discrption,
      id: id ?? this.id,
      discount: discount ?? this.discount,
      nameAr: nameAr ?? this.nameAr,
      discrptionAr: discrptionAr ?? this.discrptionAr,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'name_ar': nameAr,
      'discrption_ar': discrptionAr,
      'discrption': discrption,
      'id': id,
      'discount': discount,
    };
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      name: map['name'] as String,
      discrption: map['discrption'] as String,
      nameAr: map['name_ar'] as String,
      discrptionAr: map['discrption_ar'] as String?,
      id: map['id'] as String,
      discount: map['discount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubCategory(name: $name, discrption: $discrption, id: $id, discount: $discount)';
  }

  @override
  bool operator ==(covariant SubCategory other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.discrption == discrption &&
        other.id == id &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        discrption.hashCode ^
        id.hashCode ^
        discount.hashCode;
  }
}

class Order {
  String? uid;
  double? total;
  String? status;
  List<Product>? products;
  Timestamp? timestamp;

  Order({
    this.uid,
    this.total,
    this.status,
    this.products,
    this.timestamp,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        uid: json["uid"],
        timestamp: json["createdAt"],
        total: json["total"],
        status: json["status"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "total": total,
        "status": status,
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
