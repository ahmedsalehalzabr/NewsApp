import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:posts/controller/product_controller.dart';
import 'package:posts/core/constant/color.dart';
import 'package:posts/core/functions/translateDatabase.dart';
import 'package:get/get.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    ProductControllerImp controller = Get.put(ProductControllerImp());
   // ProductControllersImp controller = Get.put(ProductControllersImp());
    return Scaffold(
      appBar: AppBar(
        title: Text("Offers"),
      ),
      body: GetBuilder<ProductControllerImp>(
          builder: (controller) => ListView.builder(
              itemCount: controller.productList.length,
              itemBuilder: (context,index) {
                return  Card(
                    child: Stack(
                        children: [
                      Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              // لاحتواء الصورة ضمن الحواف المدورة
                              child: CachedNetworkImage(
                                imageUrl:controller.productList[index].postList![index].imageUrl.toString(),
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("${translateDatabase(controller.productList[index].categoryTitle, controller.productList[index].categoryGroupName)}",
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Rating 5 ", textAlign: TextAlign.center),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 22,
                                  child: Row(
                                    children: [
                                      ...List.generate(
                                          5,
                                              (index) => Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Colors.amberAccent,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${controller.productList[index].postList![index].nid} \$",
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "sans")),
                                Obx(
                                      () => IconButton(
                                    onPressed: () {
                                      controller.manageFavourites(controller.productList[index].id.toString());
                                    },
                                    icon: controller.isFavourites(controller.productList[index].id.toString())
                                        ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                        : Icon(
                                      Icons.favorite_outline,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                            ),
                          if (controller.productList[index].categoryTitle != null && controller.productList[index].categoryTitle! != 0)
                            Positioned(
                              top: 4,
                              left: 4,
                              child: Image.asset("assets/images/onesale.png", width: 40),
                            )
                        ]),
                );}
          )),
    );
  }
}
