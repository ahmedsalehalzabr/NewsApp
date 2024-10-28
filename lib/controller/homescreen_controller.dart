import 'package:flutter/material.dart';
import 'package:posts/view/screen/homepage.dart';
import 'package:posts/view/screen/offers.dart';
import 'package:posts/view/screen/settings.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;

  List<Widget> listPage = [
    const HomePage(),
    const Settings(),
    const Offers(),
    Text("favorate")
  ];

  List  titlebottomappbar = [
    "Home" ,
    "Settings" ,
    "Offers" ,
    "Favorite"
  ] ;


  List<IconData> iconsbottomappbar = [
    Icons.home,
    Icons.settings,
    Icons.local_offer,
    Icons.favorite
  ];
  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}