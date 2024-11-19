import 'dart:io';
import 'package:flutter/material.dart';
import 'package:posts/controller/homescreen_controller.dart';
import 'package:posts/core/constant/color.dart';
import 'package:get/get.dart';
import 'package:posts/view/screen/widget/home/customappbarhomescreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => Scaffold(
          // appBar: AppBar(
          //   backgroundColor:  Colors.white,
          //
          //   actions: [
          //     IconButton(
          //       icon: Icon(
          //         Icons.search,
          //         color: AppColor.primaryColor,
          //       ),
          //       onPressed: () {
          //         showModalBottomSheet(
          //           context: context,
          //           builder: (context) {
          //             return SingleChildScrollView(
          //               child: Container(
          //                 height: 500,
          //                 width: 500,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(5),
          //                   child: Column(
          //                     children: [
          //
          //                       SearchFormText(),
          //                       SizedBox(height: 5),
          //                       SearchScreen(),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //           },
          //         );
          //       },
          //     ),
          //     SizedBox(
          //       width: 1,
          //     ),
          //
          //   ],
          // ),
          // floatingActionButton: FloatingActionButton(
          //     onPressed: () { Get.offAllNamed(AppRoute.cartScreen);},
          //     child: const Icon(Icons.shopping_basket_outlined)),
          // floatingActionButtonLocation:
          // FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomAppBarHome(),
          body: WillPopScope(
            child: controller.listPage.elementAt(controller.currentpage),
            onWillPop: (){
              Get.defaultDialog(
                title: "Warning",
                titleStyle: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                middleText: "Do You Want To Exit The App",
                onCancel: (){},
                  cancelTextColor: AppColor.primaryColor,
                  confirmTextColor: AppColor.primaryColor,
                  buttonColor: AppColor.thirdColor,
                onConfirm: (){
                exit(0);
                }
              );
              return Future.value(false);
            },
          )
        ));
  }
}