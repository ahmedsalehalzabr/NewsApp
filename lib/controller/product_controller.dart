
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:posts/core/services/product_services.dart';
import 'package:posts/core/services/services.dart';
import 'package:posts/models/product_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductController extends GetxController {
  initialData();
  getdata();
  onInit();
  getProducts();
  goToPageProductDetails(ProductModel productModel);
}

class ProductControllerImp extends ProductController {
  MyServices myServices = Get.find();

  String? username;
  String? id;

  var productList = <ProductModel>[].obs;
  var isLoading = true.obs;
  var favouritesList = <ProductModel>[].obs;
  var sharedPreferences = SharedPreferences.getInstance();
  var searchList = <ProductModel>[].obs;
  ProductServices productService = ProductServices();

  void manageFavourites(String catalogId) async {
    var existingIndex =
    favouritesList.indexWhere((element) => element.id == catalogId);

    if (existingIndex >= 0) {
      favouritesList.removeAt(existingIndex);
      var prefs = await sharedPreferences;
      await prefs.remove("isFavouritesList");
    } else {
      favouritesList.add(
          productList.firstWhere((element) => element.id == catalogId));
      var prefs = await sharedPreferences;
      var favouritesListJson =
      favouritesList.map((product) => product.toJson()).toList();
      await prefs.setStringList("isFavouritesList", favouritesListJson.map((e) => json.encode(e)).toList());
    }
  }

  bool isFavourites(String catalogId) {
    return favouritesList.any((element) => element.id == catalogId);
  }

  TextEditingController searchTextController = TextEditingController();
  int get count => favouritesList.length;
  void addSearchToList(String searchName) {
    searchName = searchName.toLowerCase();

    searchList.value = productList.where((search) {
      var searchTitle = search.categoryTitle!.toLowerCase();

      return searchTitle.contains(searchName);
    }).toList();

    update();
  }

  void clearSearch() {
    searchTextController.clear();
    addSearchToList("");
  }

  void getProducts() async {
    var product = await ProductServices.getProduct();

    try {
      isLoading(true);
      if (product!.isNotEmpty) {
        productList.addAll(product);
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() async {
    super.onInit();

    SharedPreferences prefs = await sharedPreferences;
    List<String>? storedShoppings = prefs.getStringList('isFavouritesList');

    if (storedShoppings != null) {
      favouritesList = storedShoppings
          .map((e) => ProductModel.fromJson(json.decode(e)))
          .toList()
          .obs;
    }
    getProducts();
  }

  @override
  initialData() {
    username = myServices.sharedPreferences.getString("token");
    id = myServices.sharedPreferences.getString("email");
  }

  @override
  getdata() async {
    update();
  }

  @override
  goToPageProductDetails(productModel) {
    Get.toNamed("productdetails", arguments: {"itemsmodel": productModel});
  }
}