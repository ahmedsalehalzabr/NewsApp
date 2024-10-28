import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:posts/controller/home_controller.dart';
import 'package:posts/controller/product_controller.dart';
import 'package:posts/linkapi.dart';
import 'package:posts/view/screen/widget/home/customappbar.dart';
import 'package:posts/view/screen/widget/home/customerproduct.dart';
import 'package:posts/view/screen/widget/home/customtitlehome.dart';
import 'package:posts/view/screen/widget/home/listcategoryhome.dart';
import 'package:posts/view/screen/widget/item/customsladeritem.dart';

import 'package:get/get.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    ProductControllerImp controllers = Get.put(ProductControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: (controller) => Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                CustomAppBar(
                  titleappbar: "SAP Soft Pro",
                  onPressedIcon: () {},
                  onPressedSearch: () {},
                ),
                // const CustomCard(
                //     title: "A summer surprise", body: "Cashback 20%"),
                 InkWell(
                    onTap: () {
                      // Get.offNamed(Routes.productScreen);
                    },
                    child: CarouselSlider.builder(
                      itemCount: 3,
                      carouselController: carouselController,
                      options: CarouselOptions(
                          height: 300,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          autoPlayInterval: const Duration(seconds: 5),
                          viewportFraction: 1,
                          onPageChanged: (index, reson) {
                            // setState(() {
                            //   currentPage = index;
                            // });
                          }),
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(AppLink.signUp + controllers.productList[0].postList![index].imageUrl.toString()),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                    ),
                  ),

                //  CustomTitleHome(
                //   title: "39".tr,
                // ),
                // ListCategoriesHome(),
                 CustomTitleHome(
                  title: "40".tr,
                ),
                ListProductHome(),
              ],
            )));
  }
}
