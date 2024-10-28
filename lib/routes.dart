

import 'package:posts/view/screen/homescreen.dart';
import 'package:posts/view/screen/language.dart';

import 'package:posts/view/screen/search_screen.dart';
import 'package:get/get.dart';

import 'core/constant/routes.dart';
import 'core/middleware/mymiddleware.dart';


List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const Language() , middlewares: [
MyMiddleWare() 
]),

  GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),

 GetPage(name: AppRoute.searchScreen, page: () =>  SearchScreen()),
 // GetPage(name: AppRoute.favoriteScreen, page: () =>  FavoriteScreen()),

  //GetPage(name: AppRoute.offers, page: () => const Offers()),
];

class ForgetPassword {
  const ForgetPassword();
}
 