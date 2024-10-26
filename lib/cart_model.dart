// To parse this JSON data, do
//
//     final cartModelApi = cartModelApiFromJson(jsonString);

import 'dart:convert';

CartModelApi cartModelApiFromJson(String str) => CartModelApi.fromJson(json.decode(str));



class CartModelApi {
    List<Cart> carts;

    CartModelApi({
        required this.carts,
    });

    factory CartModelApi.fromJson(Map<String, dynamic> json) => CartModelApi(
        carts: List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
    );

    
}

class Cart {
    int id;
    List<Product> products;

    Cart({
        required this.id,
        required this.products,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

  
}

class Product {
    int id;
    String title;
    double price;
    int quantity;
    double total;
    double discountPercentage;
    double discountedTotal;
    String thumbnail;

    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.quantity,
        required this.total,
        required this.discountPercentage,
        required this.discountedTotal,
        required this.thumbnail,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        total: json["total"]?.toDouble(),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        discountedTotal: json["discountedTotal"]?.toDouble(),
        thumbnail: json["thumbnail"],
    );

    
}
