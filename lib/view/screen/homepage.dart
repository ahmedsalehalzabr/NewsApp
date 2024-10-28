import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:posts/controller/home_controller.dart';
import 'package:posts/controller/product_controller.dart';
import 'package:posts/linkapi.dart';
import 'package:posts/view/screen/widget/drawer.dart';
import 'package:posts/view/screen/widget/home/customappbar.dart';
import 'package:posts/view/screen/widget/home/customerproduct.dart';
import 'package:posts/view/screen/widget/home/customtitlehome.dart';
import 'package:posts/view/screen/widget/home/listcategoryhome.dart';
import 'package:posts/view/screen/widget/item/customsladeritem.dart';

import 'package:get/get.dart';

import 'widget/home/SearchFormText.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    ProductControllerImp controllers = Get.put(ProductControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: (controller) => Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Scaffold(
                drawer: const DrawerWidget(),
              appBar:AppBar(
                backgroundColor: Get.isDarkMode ? Colors.black26 : Colors.white,
                elevation: 0.0,
                titleSpacing: 20.0,
                leading: Builder(
                  builder: (ctx) {
                    return IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        Scaffold.of(ctx).openDrawer();
                      },
                    );
                  },
                ),
                title: IconButton(
                  onPressed: () {
                  //  Get.offNamed(Routes.homeScreen);
                  },
                  icon: Image.asset(
                    'assets/images/logo.png',
                    width: 40,
                    height: 40,

                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                              height: 400,
                              width: 400,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [

                                    SearchFormText(),
                                    // SizedBox(height: 5.h,),
                                    // CardSearch(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    width: 1,
                  ),


                  // Obx(
                  //       () => Center(
                  //     child: Badge(
                  //
                  //       label: Text(cartController.quantity().toString()),
                  //       child: IconButton(
                  //         icon: Icon(
                  //           Icons.shopping_cart,
                  //           color: Get.isDarkMode ? Colors.white : Colors.black,
                  //
                  //         ),
                  //         onPressed: () {
                  //           Get.toNamed(Routes.cartScreen);
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ) ,
              body:
              ListView(
                children: [

                  // CustomAppBar(
                  //   titleappbar: "SAP Soft Pro",
                  //   onPressedIcon: () {},
                  //   onPressedSearch: () {},
                  // ),
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
                            height: 250,
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
              ),
            )));
  }
}
