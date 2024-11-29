import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posts/controller/productdetails_controller.dart';
import 'package:posts/core/constant/color.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // عدد العناصر في كل صفحة
    const int itemsPerPage = 4;

    Catalog2Controller controller = Get.put(Catalog2Controller());

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Screen"),
      ),
      body: GetBuilder<Catalog2Controller>(builder: (controller) {
        if (controller.cgModel == null) {
          return Center(child: CircularProgressIndicator());
        }

        // إجمالي عدد العناصر
        final totalItems = controller.cgModel!.list!.length;
        // إجمالي عدد الصفحات
        final totalPages = (totalItems / itemsPerPage).ceil();
        // الصفحة الحالية
        final RxInt currentPage = 0.obs;

        return Column(
          children: [
            // قائمة العناصر
            Expanded(
              child: Obx(() {
                // تحديد البيانات للصفحة الحالية
                final startIndex = currentPage.value * itemsPerPage;
                final endIndex = (startIndex + itemsPerPage).clamp(0, totalItems);
                final currentItems = controller.cgModel!.list!.sublist(startIndex, endIndex);

                return ListView.builder(
                  itemCount: currentItems.length,
                  itemBuilder: (context, index) {
                    var weather = currentItems[index];
                    var temp = weather.main?.temp?.toString() ?? "البيانات غير متوفرة";

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: "https://openweathermap.org/img/wn/03d@2x.png",
                                height: 200,
                                fit: BoxFit.fill,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Temp: $temp",
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TempMin: ${weather.main?.tempMin?.toString() ?? "غير متوفر"}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 22,
                                  child: Row(
                                    children: List.generate(
                                      5,
                                          (index) => Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.amberAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TempMax: ${weather.main?.tempMax?.toString() ?? "غير متوفر"}",
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
                    );
                  },
                );
              }),
            ),
            // أزرار التنقل
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: currentPage.value > 0
                        ? () => currentPage.value--
                        : null,
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Page ${currentPage.value + 1} of $totalPages",
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: currentPage.value < totalPages - 1
                        ? () => currentPage.value++
                        : null,
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              );
            }),
          ],
        );
      }),
    );
  }
}
