import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Views/Pages/View_models/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/Views/Pages/View_models/home_cubit/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/product_item.dart';
import 'package:ecommerce_app/Views/Pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeTabBarView extends StatelessWidget {
  const HomeTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              bottom: 24.0,
            ), // مسافة أمان أسفل القائمة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //--------------- Carousel Slider ------------------//
                CarouselSlider.builder(
                  itemCount: state.carouselItems.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: state.carouselItems[index].imgUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 190, // تقليل الارتفاع قليلًا ليكون متناسقاً
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction:
                        0.92, // إظهار أجزاء بسيطة من الصور المجاورة لشكل أحدث
                    autoPlayInterval: const Duration(seconds: 4),
                  ),
                ),

                const SizedBox(height: 24.0),

                //--------------- Section Title (New Arrivals) ------------------//
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "New Arrivals 🔥",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Action for See All
                      },
                      child: Text(
                        "See All",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),

                //--------------- Products Grid View ------------------//
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing:
                        16, // مسافة عمودية أوسع ومريحة بين الكارتات
                    crossAxisSpacing: 16, // مسافة أفقية متوازنة بين الأعمدة
                    childAspectRatio:
                        0.68, // تعديل النسبة لتتناسب مع محتوى الكارت بدون Overflow
                  ),
                  itemBuilder: (context, index) {
                    final productId = state.products[index].id;
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => pushScreen(
                        context,
                        screen: BlocProvider(
                          create: (context) {
                            final cubit = ProductDetailsCubit();
                            cubit.getProductDetails(productId);
                            return cubit;
                          },
                          child: ProductDetailsPage(productId: productId),
                        ),
                        withNavBar: false,
                      ),
                      child: ProductItem(product: state.products[index]),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
