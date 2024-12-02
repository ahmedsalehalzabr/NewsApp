import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:posts/core/constant/color.dart';
import 'package:posts/core/constant/routes.dart';
import 'package:posts/core/functions/translateDatabase.dart';
import 'package:posts/linkapi.dart';
import 'package:posts/models/product_model.dart';
import 'package:posts/view/screen/widget/item/customsladeritem.dart';
import 'package:posts/view/screen/widget/item/customtitildetails.dart';
import 'package:posts/view/screen/widget/product_details/priceandcont.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';


class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  ProductDetailsScreen({
    required this.productModel,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //     height: 40,
        //     child: MaterialButton(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10)),
        //         color: AppColor.primaryColor,
        //         onPressed: () {
        //           // cartController.addCarts(productModel.id );
        //           // cartController.refreshPage();
        //          // Get.toNamed(AppRoute.cartScreen);
        //           Get.offAllNamed(AppRoute.cartScreen);
        //
        //         },
        //         child: const Text(
        //           "Go To Cart",
        //           style: TextStyle(
        //               color: Colors.white, fontWeight: FontWeight.bold),
        //         ))),

    //     body:Obx(
    // () =>

          body:

      ListView(

          children: [
            ImageSliders(
              imageUrl: AppLink.signUp + productModel.postList![0].imageUrl.toString(),
            ),
            DetailsTitle(
              name:"${translateDatabase(productModel.postList![0].categoryTitle.toString(),productModel.postList![0].categoryTitle.toString())}",
              shortDescription: _cleanHtmlText(productModel.postList![0].postTitle.toString()),
            //  price:productModel.price.toString(),
              Id:productModel.postList![0].nid.toString(),

              // description: catalogModels.description.toString(),
            ),
          //  const SizedBox(height: 10),

              // PriceAndCountItems(
              //
              //     onAdd: () {
              //       // cartController.addCarts(productModel.id as String? );
              //       // cartController.refreshPage();
              //    //   cartController.addCartss(productModel.id.toString());
              //      // cartController.add();
              //     },
              //
              //
              //     onRemove: () {
              //       // cartController.deleteByItemId(productModel.id as String? );
              //       // cartController.refreshPage();
              //     //  cartController.deleteByItemIds(productModel.id.toString() );
              //      // cartController.remove();
              //     },
              //
              //   price: " ${productModel.id} ",
              //
              //   count: " ${productModel.id} ",
              //   des: " ${productModel.id} ",
              // ),

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
                    _cleanHtmlText(productModel.postList![0].body.toString()),

                    trimLines: 8,
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

          ],
        )//;}
        ),
    );
  }

  String _cleanHtmlText(String? htmlText) {
    if (htmlText == null || htmlText.isEmpty) return '';

    // تحليل النص HTML
    var document = parse(htmlText);

    // استخراج النص فقط
    String plainText = document.body?.text ?? '';

    // إزالة الأسطر الفارغة المتعددة
    plainText = plainText.replaceAll(RegExp(r'\n\s*\n'), '\n');

    // إزالة المسافات الزائدة
    plainText = plainText.trim();

    return plainText;
  }
}