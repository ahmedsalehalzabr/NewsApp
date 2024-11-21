import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:posts/controller/product_controller.dart';
import 'package:posts/controller/productdetails_controller.dart';
import 'package:posts/core/constant/color.dart';
import 'package:posts/core/functions/translateDatabase.dart';
import 'package:get/get.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    Catalog2Controller controller = Get.put(Catalog2Controller());
    // ProductControllersImp controller = Get.put(ProductControllersImp());
    return Scaffold(
      appBar: AppBar(
        title: Text("Offers"),
      ),
      body: GetBuilder<Catalog2Controller>(builder: (controller) {
        if (controller.cgModel == null) {
          return Center(
              child:
                  CircularProgressIndicator()); // إذا كانت البيانات غير محملة بعد
        }

        return ListView.builder(
          itemCount: 5, // أو controller.cgModel?.list?.length
          itemBuilder: (context, index) {
            var weather = controller.cgModel?.list?[index];
            var temp = weather?.main?.temp?.toString() ??
                "البيانات غير متوفرة"; // تعديل هنا

            return Card(
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
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://openweathermap.org/img/wn/03d@2x.png",
                            height: 200,
                            fit: BoxFit.fill,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(temp, // عرض القيمة هنا
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                weather?.main?.tempMin?.toString() ??
                                    "غير متوفر",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
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
                                          )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${weather?.main?.tempMax?.toString() ?? "غير متوفر"}",
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // if (temp != "البيانات غير متوفرة")  // فقط إذا كانت البيانات متوفرة
                  //   Positioned(
                  //     top: 4,
                  //     left: 4,
                  //     child: Image.asset("assets/images/onesale.png", width: 40),
                  //   ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
