import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:posts/linkapi.dart';
import 'package:posts/models/categories_model.dart';

class CategoryServices{

  static var client = http.Client();
  static Future<List<CategoryModel>?> getCategory() async{

    var response = await client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.homePage));
    if(response.statusCode == 200)
    {
      var convertedJosnData = jsonDecode(response.body);
      return (convertedJosnData as List).map((e) => CategoryModel.fromJson(e)).toList();
    }
    else
    {
      return null;
    }
  }
}