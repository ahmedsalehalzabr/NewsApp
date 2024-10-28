import 'dart:convert';

import 'package:posts/linkapi.dart';

import 'package:posts/models/orders_model.dart';
import 'package:posts/models/rating_model.dart';
import 'package:http/http.dart' as http;


class OrdersServices{

  static var client = http.Client();




  static Future<List<OrdersModel>?> getOrderByUserId(String userId) async{

    var response = await client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.orderUserId + "$userId"));
    if(response.statusCode == 200)
    {
      print("Response status: ${response.statusCode}, body: ${response.body}");
      var convertedJosnData = jsonDecode(response.body);
      return (convertedJosnData as List).map((e) => OrdersModel.fromJson(e)).toList();
    }
    else
    {
      return null;
    }
  }

  static Future<List<OrdersModel>?> getOrderById(String id) async{

    var response = await client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.orderId + "$id"));
    if(response.statusCode == 200)
    {
      print("Response status: ${response.statusCode}, body: ${response.body}");
      var convertedJosnData = jsonDecode(response.body);
      return (convertedJosnData as List).map((e) => OrdersModel.fromJson(e)).toList();
    }
    else
    {
      return null;
    }
  }


  static Future<OrdersModel?> addOrdersItem(String userId,  String addressid, String ordrsType,
      String priceDelivery, String ordersPrice, String totalPrice,String paymentMethod,
      String item,String quantity, String price) async {
    // تأكد من أن الجسم يحتوي على البيانات المطلوبة
    var requestBody = {
      'userId': userId,
      'addressid': addressid,
      'ordrsType': ordrsType,
      'priceDelivery': priceDelivery,
      'ordersPrice': ordersPrice,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      "item": item,
      "quantity": quantity,
      "price": price,
      // "orderItems": cartList

    };
    var response = await http.post(
      Uri.parse("${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.order}"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody), // استخدام الجسم المعدل
    );
    print("Response status: ${response.statusCode}, body: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      return OrdersModel.fromJson(responseData);
    } else {
      print("Failed to add item: ${response.statusCode} - ${response.body}");
      return null;
    }
  }


  static Future<RatingModel?> addOrdersRating(String id,  double rating, String communtRating,
      ) async {
    // تأكد من أن الجسم يحتوي على البيانات المطلوبة
    var requestBody = {
      'id': id,
      'rating': rating,
      'communtRating':communtRating,

    };

    var response = await http.post(
      Uri.parse("${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.rating}"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody), // استخدام الجسم المعدل
    );
    print("Response status: ${response.statusCode}, body: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      return RatingModel.fromJson(responseData);
    } else {
      print("Failed to add item: ${response.statusCode} - ${response.body}");
      return null;
    }
  }

  static Future<OrdersModel?> deleteOrderItem(String id) async {
    var response = await http.delete(
      Uri.parse("${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.orderUserId}$id"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print("Response status: ${response.statusCode}, body: ${response.body}"); // طباعة الحالة والرد

    if (response.statusCode == 200 || response.statusCode == 204) {
      var responseData = jsonDecode(response.body);
      return OrdersModel.fromJson(responseData);
    } else {
      print("Failed to delete item: ${response.statusCode}");
      return null;
    }
  }

}


