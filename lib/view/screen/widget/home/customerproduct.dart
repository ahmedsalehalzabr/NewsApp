import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:posts/controller/product_controller.dart';
import 'package:posts/core/constant/color.dart';
import 'package:posts/core/functions/translateDatabase.dart';
import 'package:posts/linkapi.dart';
import 'package:posts/models/product_model.dart';
import 'package:html/parser.dart' show parse;

class ListProductHome extends StatelessWidget {
  ListProductHome({Key? key}) : super(key: key);

  final ProductControllerImp controller = Get.put(ProductControllerImp());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.productList.isEmpty || 
          controller.productList[0].postList == null || 
          controller.productList[0].postList!.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/loading.json',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 16),
              Text(
                "لا توجد منتجات متاحة",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),  
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.productList[0].postList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3.0,
                mainAxisSpacing: 8,  
              ),
              itemBuilder: (context, index) {
                final post = controller.productList[0].postList![index];
                return Card(
                  elevation: 2,  
                  margin: const EdgeInsets.all(4),  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      // يمكن إضافة التنقل إلى صفحة التفاصيل هنا
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),  
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90,  
                            height: 130,
                            child: _buildProductImage(post.imageUrl.toString()),
                          ),
                          const SizedBox(width: 8),  
                          Expanded(
                            child: _buildProductDetails(post),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProductImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: AppLink.signUp + imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: Center(
            child: Lottie.asset(
              'assets/loading.json',
              width: 40,
              height: 40,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Icon(
            Icons.error_outline,
            color: Colors.grey,
            size: 24,
          ),
        ),
      ),
    );
  }

  String _cleanHtmlText(String? htmlText) {
    if (htmlText == null || htmlText.isEmpty) return '';
    
    // تحليل النص HTML
    var document = parse(htmlText);
    
    // استخراج النص فقط
    String plainText = document.body?.text ?? '';
    
    // إزالة الأسطر الفارغة المتعددة
    plainText = plainText.replaceAll(RegExp(r'\n\s*\n'), '\n');
    
    // إزالة المسافات الزائدة
    plainText = plainText.trim();
    
    return plainText;
  }

  Widget _buildProductDetails(PostList post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          translateDatabase(
            post.postTitle.toString(),
            post.postTitle.toString(),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Flexible(
          child: Text(
            translateDatabase(
              _cleanHtmlText(post.body?.toString()),
              _cleanHtmlText(post.body?.toString()),
            ),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null) return 'غير محدد';
    try {
      final DateTime dateTime = DateTime.parse(date);
      return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
    } catch (e) {
      return 'غير محدد';
    }
  }
}
