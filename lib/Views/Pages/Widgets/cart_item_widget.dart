import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Views/Pages/View_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/counter_widget.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartItem});
  final AddToCartModel cartItem;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Row(
        children: [
          //Image of the product
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CachedNetworkImage(
                imageUrl: cartItem.product.imgUrl,
                fit: BoxFit.fill,
                width: 125,
                height: 125,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          ),

          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Size: ",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.grey),
                      ),
                      TextSpan(
                        text: cartItem.size,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12.0),

                BlocBuilder<CartCubit, CartState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is QuantityCounterLoaded &&
                      current.productId == cartItem.product.id,
                  builder: (context, state) {
                    if (state is QuantityCounterLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CounterWidget(
                            value: state.value,
                            productId: cartItem.product.id,
                            cubit: cubit,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "\$",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(color: AppColors.primary),
                                ),
                                TextSpan(
                                  text:
                                      "\$${(state.value * cartItem.product.price).toStringAsFixed(1)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          value: cartItem.quantity,
                          productId: cartItem.product.id,
                          cubit: cubit,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "\$",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(color: AppColors.primary),
                              ),
                              TextSpan(
                                text:
                                    "\$${cartItem.totalPrice.toStringAsFixed(1)}",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
