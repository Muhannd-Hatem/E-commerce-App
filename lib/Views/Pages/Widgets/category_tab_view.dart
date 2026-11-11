import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/category_product_details.dart';
import 'package:ecommerce_app/models/category_tab_model.dart';
import 'package:flutter/material.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetail()),
        );
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: category.length,
        itemBuilder: (context, index) {
          final categoryItem = category[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: categoryItem.imgUrl,
                        fit: BoxFit.cover,
                        // placeholder: (context, url) =>
                        //     const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),

                    // White Overlay
                    Positioned.fill(
                      child: Container(color: Colors.white.withValues(alpha: 0.15)),
                    ),

                    // Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categoryItem.title,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${categoryItem.count} Product",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
