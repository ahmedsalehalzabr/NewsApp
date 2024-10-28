


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posts/controller/category_id_controller.dart';
import 'package:posts/controller/home_controller.dart';
import 'package:posts/models/categories_model.dart';
import 'package:posts/models/category_id_model.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  ScrollController _scrollController = ScrollController();
  HomeControllerImp controller = Get.put(HomeControllerImp());
  CategoryIdController controller2 = Get.put(CategoryIdController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(child: Text('Menu')),
                SizedBox(
                  width: 100,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Get.isDarkMode ? Colors.red : Colors.purple,
                    ),
                  ),
                ),
              ],
            ),


            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 5,
            ),


            Column(
              children: controller.categoryList.isNotEmpty
                  ? controller.categoryList.map((category) {
                return _listTiles(
                  label: category.categoryQroupTitle.toString(),
                  fct: () {
                    _entertainments(context, category.categoryQroupTitle.toString()); // تمرير الـ ID عند النقر
                  },
                  icon: Icons.arrow_right,
                );
              }).toList()
                  : [SizedBox()],
              // عرض عنصر فارغ إذا كانت القائمة فارغة
            ),


            const Divider(
              thickness: 1,
            ),

          ],
        ));
  }

  void _entertainments(BuildContext context, String id ) { // استخدام String لـ id
    // استدعاء دالة fetchCategoryId لجلب البيانات
    controller2.fetchCategoryId(id);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context, false),
                icon: const Icon(
                  Icons.arrow_left_outlined,
                ),
              ),
              SizedBox(width: 5),
              Center(
                child: Text(' $id'), // عرض الـ ID هنا
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Options'.tr,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.arrow_downward_sharp),
            ],
          ),
          actions: [
            Obx(() { // استخدام Obx لمراقبة تغييرات categoryIdList
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: ListView.builder(
                      itemCount: controller.categoryList.length, // عدد الفئات الرئيسية
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, categoryIndex) {
                        final category = controller.categoryList[categoryIndex]; // الفئة الحالية
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.categoryQroupTitle.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                              itemCount: category.categoryList!.length, // عدد العناصر في الفئة الحالية
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(), // لمنع التمرير في الداخل
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                final subItem = category.categoryList![index]; // العنصر الحالي
                                return buildCardItems2(
                                  name: subItem.categoryTitle.toString(),
                                  category1001Model: category,
                                  onTap: () {
                                    // تنفيذ أي إجراء عند النقر بناءً على الـ ID
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    )

                  ),
                ],
              );
            }),
          ],
        );
      },
    );
  }



  Widget buildCardItems2({
    required String name,

    required Function() onTap,
    required CategoryModel category1001Model,
  }) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(right: 5,),

        child: Text(name
          ,
          style: TextStyle(
            fontSize: 17,
            color:Get.isDarkMode ? Colors.white : Colors.black,
            height: 2.5,
          ),),
      ),
    );
  }


  Widget _listTiles(
      {required String label, required Function fct, required IconData icon}) {
    return ListTile(
      onTap: () {
        fct();
      },
      leading: Icon(
        icon,
        color: Get.isDarkMode ? Colors.red : Colors.purple,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }

}
