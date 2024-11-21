import 'package:cached_network_image/cached_network_image.dart';
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
  final ScrollController _scrollController = ScrollController();
  final HomeControllerImp controller = Get.put(HomeControllerImp());
  final CategoryIdController controller2 = Get.put(CategoryIdController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(child: Text('Menu')),
              const SizedBox(width: 100),
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
          const Divider(thickness: 1),
          const SizedBox(height: 5),
          Column(
            children: controller.categoryList.isNotEmpty
                ? controller.categoryList.map((category) {
              return _listTiles(
                label: category.categoryQroupTitle.toString(),
                fct: () {
                  _entertainments(context, category.categoryQroupTitle.toString());
                },
                icon: Icons.arrow_right,
              );
            }).toList()
                : [const SizedBox()],
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  void _entertainments(BuildContext context, String id) {
    // استدعاء دالة fetchCategoryId لجلب البيانات
    controller2.fetchCategoryId(id);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ' $id',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Obx(() {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: controller.categoryList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, categoryIndex) {
                          final category = controller.categoryList[categoryIndex];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.categoryQroupTitle.toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              ListView.builder(
                                itemCount: category.categoryList!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final subItem = category.categoryList![index];
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
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget buildCardItems2({
    required String name,
    required Function() onTap,
    required CategoryModel category1001Model,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 17,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            height: 2.5,
          ),
        ),
      ),
    );
  }

  Widget _listTiles({
    required String label,
    required Function fct,
    required IconData icon,
  }) {
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

