import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:posts/controller/product_controller.dart';
import 'package:posts/core/constant/color.dart';
import 'package:posts/core/functions/translateDatabase.dart';
import 'package:posts/linkapi.dart';

class ListProductHome extends StatelessWidget {
  ListProductHome({Key? key}) : super(key: key);

  final ProductControllerImp controller = Get.put(ProductControllerImp());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // التحقق من أن القائمة تحتوي على عناصر
      if (controller.productList.isEmpty || controller.productList[0].postList == null || controller.productList[0].postList!.isEmpty) {
        return Center(
          child: Text("No products available"), // نص يظهر عند عدم توفر المنتجات
        );
      }

      return Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.productList[0].postList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2,
            ), // تعديل النسبة لملاءمة التصميم
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // عرض الصورة على الجانب الأيسر
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: AppLink.signUp + controller.productList[0].postList![index].imageUrl.toString(),
                          height: 170,
                          width: 120, // ضبط العرض حسب الحاجة
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Lottie.asset('assets/loading.json'), // يظهر أثناء تحميل الصورة
                          errorWidget: (context, url, error) => Icon(Icons.error), // يظهر عند فشل تحميل الصورة
                        ),
                      ),
                      SizedBox(width: 10),
                      // عرض النص على الجانب الأيمن
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translateDatabase(
                                controller.productList[0].postList![index].postTitle.toString(),
                                controller.productList[0].postList![index].postTitle.toString(),
                              ),
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 4, // تحديد عدد الأسطر القصوى
                              overflow: TextOverflow.ellipsis, // للتأكد من النص الطويل لا يتعدى المنطقة المخصصة
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
