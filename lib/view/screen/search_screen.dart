


import 'package:awesome_rating/awesome_rating.dart';

import 'package:flutter/material.dart';
import 'package:posts/controller/product_controller.dart';
import 'package:posts/linkapi.dart';
import 'package:posts/models/product_model.dart';
import 'package:posts/view/screen/product_details_screen.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);
  ProductControllerImp controller =    Get.put(ProductControllerImp());

 // final cartController = Get.find<CartController>();




  //final List<CatalogModels> list;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Expanded(
          child: Container(),
        );
      } else {
        return Expanded(
          child: controller.searchList.isEmpty &&
              controller.searchTextController.text.isNotEmpty
              ? Get.isDarkMode
              ? Image.asset("assets/images/search.webp")
              : Image.asset("assets/images/search.webp")
              : GridView.builder(
            itemCount: controller.searchList.isEmpty
                ? controller.productList.length ?? 0
                : controller.searchList.length,
            gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 2,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 2.0,
              maxCrossAxisExtent: 200,
              mainAxisExtent: 272,
            ),
            itemBuilder: (context, index) {
            final  oo = controller.productList[index];
              if (controller.searchList.isEmpty) {
                return buildCardItems(
                    image: controller.productList[index].postList![index].imageUrl.toString(),
                    name: controller.productList[index].categoryTitle.toString(),
                    platformId: controller.productList[index].id.toString(),
                    regionId: controller.productList[index].categoryGroupName.toString(),
                    catalogId: controller.productList[index].id.toString(),
                    productModels: controller.productList[index],
                    // catalogProductModels: controller2.catalogProductModels!.data.products[0],
                    //  productModel: productController.productList[index],
                    //  Id: productController.productList[index].catalogId.toString(),
                    onTap: () {
                      Get.to(() => ProductDetailsScreen(
                        productModel: controller.productList[index],
                        // id:cartController.cartList[0].items![index].id.toString(),
                        // quantity:cartController.cartList[0].items![index].quantity ?? 0,
                        // price:cartController.cartList[0].items![index].price ?? 0,
                        //  catalogProductModels: controller2.catalogProductModels!.data.products[0],
                        //  productModel:productController.productList[index]

                      ));
                    });
              } else {
                return buildCardItems(
                    image: controller.searchList[index].postList![index].imageUrl.toString(),
                    name: controller.searchList[index].categoryTitle.toString(),
                    platformId: controller.searchList[index].id.toString(),
                    regionId: controller.searchList[index].categoryGroupName.toString(),
                    catalogId: controller.searchList[index].id.toString(),
                    productModels: controller.searchList[index],
                    // catalogProductModels: controller2.catalogProductModels!.data.products[index],
                    //productModel: productController.productList[index],
                    // Id: productController.productList[index].catalogId.toString(),
                    onTap: () {
                      Get.to(() => ProductDetailsScreen(
                        productModel: controller.searchList[index],
                        //  catalogProductModels: controller2.catalogProductModels!.data.products[index],
                        // id:cartController.cartList[0].items![index].id.toString(),
                        // quantity:cartController.cartList[0].items![index].quantity ?? 0,
                        // price:cartController.cartList[0].items![index].price ?? 0,
                        //   productModel:productController.productList[index]
                      ));
                    }
                );
              }

            },
          ),
        );
      }
    });
  }


  Widget buildCardItems({
    required String image,
    required String name,
    // required ProductModel productModel,
    // required String Id,
    required String platformId,
    required String regionId,
    required String catalogId,
    required ProductModel productModels,
    // required CatalogProductModels catalogProductModels,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Get.isDarkMode ? Colors.black12 : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1.0,
                blurRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.manageFavourites(catalogId);
                      },
                      icon: controller.isFavourites(catalogId)
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          :  Icon(
                        Icons.favorite_outline,
                        color:Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     cartController.addProductToCart(catalogModels);
                    //   },
                    //   icon: const Icon(
                    //     Icons.shopping_cart_outlined,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    Text(
                      regionId,style: TextStyle(
                      color:  Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 145,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // لاحتواء الصورة ضمن الحواف المدورة
                  child: Image.network(
                    AppLink.signUp + image,
                    fit: BoxFit.fill, // ضبط حجم الصورة لتناسب الحاوية
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name",
                      style:  TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     right: 3,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       const  AwesomeStarRating(
                    //
                    //         color: Colors.orange,
                    //         borderColor: Colors.orange,
                    //         starCount: 5,
                    //         spacing: 1,
                    //         size: 12,
                    //         allowHalfRating: true,
                    //
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
