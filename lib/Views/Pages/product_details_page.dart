import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Views/Pages/View_models/home_cubit/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/counter_widget.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: context.read<ProductDetailsCubit>(),
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        final size = MediaQuery.of(context).size;

        //--------------- Loading ------------------//
        if (state is ProductDetailsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        //--------------- Loaded ------------------//
        else if (state is ProductDetailsLoaded) {
          final product = state.product;
          final cubit = context.read<ProductDetailsCubit>();

          return Scaffold(
            extendBodyBehindAppBar: true,

            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Product Details',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ],
            ),

            body: Stack(
              children: [
                //--------------- Product Image ------------------//
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.55,
                      child: CachedNetworkImage(
                        imageUrl: product.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                //--------------- White Details Container ------------------//
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.47),
                  child: Container(
                    width: double.infinity,
                    height: size.height * 2,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.02),

                          //--------------- Product Info ------------------//
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //--------------- Left Side ------------------//
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),

                                    const SizedBox(height: 5),

                                    //--------------- Average Rating ------------------//
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: AppColors.yellow,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          product.avarageRate.toStringAsFixed(
                                            1,
                                          ),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          '(320 Review)',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 15),

                              //--------------- Counter ------------------//
                              BlocBuilder<
                                ProductDetailsCubit,
                                ProductDetailsState
                              >(
                                bloc: cubit,
                                buildWhen: (previous, current) =>
                                    current is QuantityCounterLoaded ||
                                    current is ProductDetailsLoaded,
                                builder: (context, state) {
                                  if (state is QuantityCounterLoaded) {
                                    return CounterWidget(
                                      value: state.value,
                                      productId: product.id,
                                      cubit: cubit,
                                    );
                                  }

                                  if (state is ProductDetailsLoaded) {
                                    return CounterWidget(
                                      value: state.product.quantity,
                                      productId: product.id,
                                      cubit: cubit,
                                    );
                                  }

                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.02),

                          //--------------- Size ------------------//
                          Text(
                            "Size",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          const SizedBox(height: 10),

                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is SelectedSize ||
                                current is ProductDetailsLoaded,
                            builder: (context, state) {
                              return Row(
                                children: ProductSize.values.map((size) {
                                  return InkWell(
                                    onTap: () {
                                      cubit.selectSize(size);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            state is SelectedSize &&
                                                state.size == size
                                            ? Theme.of(context).primaryColor
                                            : const Color.fromARGB(
                                                255,
                                                206,
                                                206,
                                                206,
                                              ),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        size.name.toUpperCase(),
                                        style:
                                            state is SelectedSize &&
                                                state.size == size
                                            ? const TextStyle(
                                                color: AppColors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              )
                                            : const TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),

                          const SizedBox(height: 10),

                          //--------------- Description ------------------//
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),

                          const Spacer(),

                          //--------------- Bottom Bar ------------------//
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                //--------------- Price ------------------//
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '\$',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                      ),
                                      TextSpan(
                                        text: " ${product.price}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Push button to the right
                                const Spacer(),

                                //--------------- Add To Cart ------------------//
                                SizedBox(
                                  height: 50,
                                  child:
                                      BlocBuilder<
                                        ProductDetailsCubit,
                                        ProductDetailsState
                                      >(
                                        bloc: cubit,
                                        buildWhen: (previous, current) =>
                                            current is ProductAddedToCart ||
                                            current is ProductAddingToCart,
                                        builder: (context, state) {
                                          if (state is ProductAddingToCart) {
                                            return ElevatedButton(
                                              onPressed: null,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.deepPurple,
                                                foregroundColor: Colors.white,
                                              ),
                                              child:
                                                  const CircularProgressIndicator.adaptive(),
                                            );
                                          } else if (state
                                              is ProductAddedToCart) {
                                            return ElevatedButton(
                                              onPressed: null,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.deepPurple,
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: const Text(
                                                'Added To Cart',
                                              ),
                                            );
                                          } else {
                                            return ElevatedButton.icon(
                                              onPressed: () {
                                                cubit.addToCart(product.id);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.deepPurple,
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              icon: const Icon(
                                                Icons.shopping_bag_outlined,
                                              ),
                                              label: const Text("Add to Cart"),
                                            );
                                          }
                                        },
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        //--------------- Error ------------------//
        else if (state is ProductDetailsError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        //--------------- Unknown ------------------//
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
