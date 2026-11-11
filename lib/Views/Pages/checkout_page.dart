import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Views/Pages/View_models/add_new_cart_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/Views/Pages/View_models/home_cubit/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/checkout_headlines_item.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/empty_shipping_payment.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/payment_method_bottom_sheet.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/payment_method_item.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:ecommerce_app/models/location_model.dart';
import 'package:ecommerce_app/models/payment_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  Widget _buildPaymentCartItem(
    PaymentCartModel? chosenCart,
    BuildContext context,
  ) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);

    if (chosenCart != null) {
      return PaymentMethodItem(
        paymentCart: chosenCart,
        onitemTaped: () {
          showModalBottomSheet(
            isScrollControlled: true,

            context: context,
            builder: (_) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                child: BlocProvider(
                  create: (context) {
                    final cubit = PaymentMethodsCubit();
                    cubit.fetchPaymentMethods();
                    return cubit;
                  },
                  child: PaymentMethodBottomSheet(),
                ),
              );
            },
          ).then(
            (value) => checkoutCubit.getCartItems(),
          );
        },
      );
    } else {
      return EmptyShippingPayment(
        title: "Add Payment Cart",
        onTap: () {
          Navigator.pushNamed(context, AppRouts.addNewCartRoute).then((_) {
            checkoutCubit.getCartItems();
          });
        },
      );
    }
  }

  Widget _buildShippingItem(
    LocationModel? chosenAddress,
    BuildContext context,
  ) {
    if (chosenAddress != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: chosenAddress.imageUrl,
              width: 160,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chosenAddress.city,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.grey1),
              ),
              SizedBox(height: 8.0),
              Text(
                chosenAddress.country,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ],
      );
    } else {
      return EmptyShippingPayment(
        title: "Add Shipping Address",
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouts.chooseLocationRoute,
          ).then((_) {});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CheckoutCubit();
        cubit.getCartItems();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<CheckoutCubit>(context);

            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is CheckoutLoaded ||
                  current is CheckoutLoading ||
                  current is CheckoutError,
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is CheckoutError) {
                  return Center(child: Text(state.message));
                } else if (state is CheckoutLoaded) {
                  final cartItems = state.cartItems;
                  final chosenAddress = state.chosenAddress;

                  final chossenPaymentCart = state.chossenPaymentCart;
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CheckoutHeadlinesItem(
                              title: 'Address',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouts.chooseLocationRoute,
                                ).then((_) {
                                  cubit.getCartItems();
                                });
                              },
                            ),

                            const SizedBox(height: 16.0),
                            _buildShippingItem(chosenAddress, context),
                            const SizedBox(height: 16.0),

                            CheckoutHeadlinesItem(
                              title: 'Products',
                              numOfProducts: state.numOfProducts,
                            ),
                            const SizedBox(height: 16.0),

                            ListView.separated(
                              key: ValueKey(cartItems.length),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartItems.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 32,
                                  color: AppColors.grey,
                                );
                              },

                              itemBuilder: (context, index) {
                                final cartItem = cartItems[index];

                                return Row(
                                  children: [
                                    // صورة المنتج مع قص الحواف (BorderRadius)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: AppColors.grey2,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: cartItem.product.imgUrl,
                                          width: 125,
                                          height: 125,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                                child:
                                                    CircularProgressIndicator.adaptive(),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                child: Icon(Icons.error),
                                              ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    // التفاصيل والسعر
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItem.product.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black2,
                                                ),
                                          ),

                                          const SizedBox(height: 8),

                                          Row(
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Size: ",
                                                      style: TextStyle(
                                                        color: AppColors.grey,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: cartItem.size,
                                                      style: const TextStyle(
                                                        color: AppColors.black2,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              const Spacer(),

                                              Text(
                                                "\$${cartItem.product.price}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.black2,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            const SizedBox(height: 12.0),

                            CheckoutHeadlinesItem(title: 'Payment'),

                            const SizedBox(height: 16.0),

                            _buildPaymentCartItem(
                              chossenPaymentCart,
                              context,
                            ),
                            const SizedBox(height: 16.0),

                            Divider(
                              height: 32, // مباعدة الخط الفاصل
                              color: AppColors.grey,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.grey),
                                ),

                                Text(
                                  "\$${state.totalAmount.toStringAsFixed(1)}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium!,
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),

                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor,
                                  foregroundColor: AppColors.white,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  "Proceed to Buy",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
