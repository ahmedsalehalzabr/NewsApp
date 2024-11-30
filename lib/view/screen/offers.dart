import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:posts/controller/productdetails_controller.dart';
import 'package:posts/core/constant/color.dart';
import 'package:get/get.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});
  @override
  Widget build(BuildContext context) {

    Catalog2Controller controller = Get.put(Catalog2Controller());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Weather")),
      ),
      body: GetBuilder<Catalog2Controller>(builder: (controller) {
        if (controller.cgModel == null) {
          return Center(
              child:
                  CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.cgModel?.list?.length,
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
                        Text("Temp: ${temp}", // عرض القيمة هنا
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("City: ${controller.cgModel?.city?.name.toString()}", // عرض القيمة هنا
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("Country: ${controller.cgModel?.city?.country.toString()}", // عرض القيمة هنا
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text( "TempMin: ${weather?.main?.tempMin?.toString() ??
            "غير متوفر"}",

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text( "DateTime: ${weather?.dtTxt?.toString() ??
                                "غير متوفر"}",

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),


                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "TempMax: ${weather?.main?.tempMax?.toString() ?? "غير متوفر"}",
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "Clouds: ${weather?.clouds?.all.toString() ?? "غير متوفر"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Wind Speed: ${weather?.wind?.speed.toString() ?? "غير متوفر"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
