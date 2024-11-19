
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:posts/core/constant/color.dart';
import 'package:posts/core/constant/routes.dart';
import 'package:posts/core/functions/translateDatabase.dart';
import 'package:get/get.dart';
import 'package:posts/view/screen/widget/item/customtitildetails.dart';
import 'package:posts/view/screen/widget/product_details/priceandcont.dart';
import 'package:readmore/readmore.dart';
import 'widget/item/customsladeritem.dart';


class ProductDetailsScreen2 extends StatelessWidget {

  final String title;
  final double price;
  final String id;
  final String urlHandle;
  final String featuredImageUrl;
  final String shortDescription;
  final String des;
  final String quantity;
  ProductDetailsScreen2({
    Key? key,
    required this.id,
    required this.price,
    required this.title,
    required this.urlHandle,
    required this.featuredImageUrl,
    required this.shortDescription,
    required this.des ,
    required this.quantity
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 40,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColor.primaryColor,
                onPressed: () {
                  // cartController.addCarts(id );
                  // cartController.refreshPage();
                  Get.offAllNamed(AppRoute.cartScreen);

                },
                child: const Text(
                  "Go To Cart",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),

        body:ListView(
          children: [
            ImageSliders(
              imageUrl: featuredImageUrl,
            ),
            DetailsTitle(
              name:"${translateDatabase(urlHandle,title)}",
              shortDescription:shortDescription,
            //  price:price.toString(),
              Id:id.toString(),

              // description: catalogModels.description.toString(),
            ),
            const SizedBox(height: 10),
            PriceAndCountItems(
                onAdd: () {
                //   cartController.addCarts(id );
                // cartController.refreshPage();
                },
                onRemove: () {
                  // cartController.deleteByItemId(id);
                  // cartController.refreshPage();
                },
                price: "$price",
                count: "$quantity",
                des:"$des"
                      ),


            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color:  Colors.black,
                    ),
                  ),
                  ReadMoreText(
                    shortDescription,
                    trimLines: 1,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show More ",
                    trimExpandedText: " Show Less ",
                    lessStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:  Colors.purple,
                    ),
                    moreStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:  Colors.purple,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10),
             //  SubitemsList()

          ],
        ),
      ),
    );
  }
}
















//
// import 'package:flutter/material.dart';
// import 'package:full_ecommerce/controller/productdetails_controller.dart';
// import 'package:full_ecommerce/core/constant/color.dart';
// import 'package:full_ecommerce/view/widget/product_details/priceandcont.dart';
// import 'package:full_ecommerce/view/widget/product_details/subitemslist.dart';
// import 'package:full_ecommerce/view/widget/product_details/toppageproduct.dart';
// import 'package:get/get.dart';
//
// class ProductDetails extends StatelessWidget {
//   const ProductDetails({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     ProductDetailsControllerImp controller =
//     Get.put(ProductDetailsControllerImp());
//     return Scaffold(
//         bottomNavigationBar: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             height: 40,
//             child: MaterialButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 color: AppColor.secondColor,
//                 onPressed: () {},
//                 child: const Text(
//                   "Add To Cart",
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ))),
//         body: ListView(children: [
//           const TopProductPageDetails(),
//           const SizedBox(
//             height: 100,
//           ),
//           Container(
//             padding: const EdgeInsets.all(20),
//             child:
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text("${controller.productModel.title.toString()}",
//                   style: Theme.of(context).textTheme.headline1!.copyWith(
//                     color: AppColor.fourthColor,
//                   )),
//               const SizedBox(height: 10),
//               PriceAndCountItems(
//                   onAdd: () {}, onRemove: () {}, price: "200.0", count: "2"),
//               const SizedBox(height: 10),
//               Text(
//                   "${controller.productModel.shortDescription.toString()} ",
//                   style: Theme.of(context).textTheme.bodyText1),
//               const SizedBox(height: 10),
//               Text("Color",
//                   style: Theme.of(context).textTheme.headline1!.copyWith(
//                     color: AppColor.fourthColor,
//                   )),
//               const SizedBox(height: 10),
//               const SubitemsList()
//             ]),
//           )
//         ]));
//   }
// }