import 'package:posts/core/services/cart_services.dart';
import 'package:posts/core/services/services.dart';
import 'package:posts/models/cart_model.dart';
import 'package:posts/models/product_model.dart';
import 'package:get/get.dart';

abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImp extends ProductDetailsController {
  late ProductModel productModel;

  intialData() {
    productModel = Get.arguments['itemsmodel'];
   // quantity = productModel.quantity ?? 0;
  }

  List subitems = [
    {"name": "red", "id": 1, "active": '0'},
    {"name": "yallow", "id": 2, "active": '0'},
    {"name": "black", "id": 3, "active": '1'}
  ];
  var id;

  var cartList = <CartModel>[].obs;
  var isLoading = true.obs;


  MyServices myServices = Get.find();

  void addCarts(String? id) async {
    if (id == null) {
      print("ID is null, cannot add");
      return;
    }
    update();
    try {
      isLoading(true);
      List<CartModel>? category = await CartServices.addCart(id, myServices.sharedPreferences.getString("id")!);
      if (category != null ) {

        cartList.addAll(category);
        Get.rawSnackbar(
            title: "اشعار",
            message : "تم اضافة المنتج الى السلة ");
      }
    } finally {
      isLoading(false);
    }
    update();
  }



  void deleteByItemId(String? id) async {
    if (id == null) {
      print("ID is null, cannot delete");
      return;
    }
    update();
    try {
      isLoading(true);
      // تحويل id إلى Guid
      String itemId = id;
      String userId = myServices.sharedPreferences.getString("id")!;

      CartModel? updatedCart = await CartServices.deleteCartItem(itemId, userId);
      if (updatedCart != null) {
        // تحديث cartList بالقائمة الجديدة
        cartList.remove(itemId);
        // cartList.addAll(updatedCart.items as Iterable<CartModel>);
        Get.rawSnackbar(
            title: "اشعار",
            message: "تم ازالة المنتج من السلة ");
      } else {
        print("فشل في حذف العنصر");
      }
    } catch (e) {
      print("خطأ أثناء الحذف: $e");
    } finally {
      isLoading(false);
      print("عملية الحذف انتهت");
    }
    update();
  }

int quantity = 0;

// add() {
//   addCarts(productModel.id);
//   quantity++;
//   update();
// }
//
// remove() {
//   if (quantity > 0) {
//     deleteByItemId(productModel.id);
//     quantity--;
//     update();
//   }






  @override
  void onInit() {
    intialData();
    // addCarts(id);
    // deleteByItemId(id);

    super.onInit();
  }
}