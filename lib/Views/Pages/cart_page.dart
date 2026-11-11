import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:ecommerce_app/Views/Pages/View_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/cart_item_widget.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getCartItems();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<CartCubit>(context);
          return BlocBuilder<CartCubit, CartState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                current is CartLoaded ||
                current is CartLoading ||
                current is CartError,
            builder: (context, state) {
              //-----------cartloading state-----------//

              if (state is CartLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (state is CartLoaded) {
                final cartItems = state.cartItems;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 24.0),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return CartItemWidget(cartItem: cartItem);
                        },
                        separatorBuilder: (context, index) {
                          return Divider(height: 16, color: AppColors.grey);
                        },
                      ),
                      Divider(height: 16, color: AppColors.grey),

                      //--------------Subtotaal to Shipping to Totall------------------//
                      BlocBuilder<CartCubit, CartState>(
                        bloc: cubit,
                        buildWhen: (previous, current) =>
                            current is SubtotalUpdated,
                        builder: (context, subtotalState) {
                          if (subtotalState is SubtotalUpdated) {
                            return Column(
                              children: [
                                totalAndSubtoalWidget(
                                  title: "Subtotal",
                                  amount: subtotalState.subtotal,
                                ),

                                totalAndSubtoalWidget(
                                  title: "Shipping",
                                  amount: 10.0,
                                ),

                                SizedBox(height: 4.0),

                                DottedDashedLine(
                                  height: 2,
                                  width: double.infinity,
                                  axis: Axis.horizontal,
                                  dashColor: AppColors.grey,
                                ),

                                SizedBox(height: 4.0),

                                totalAndSubtoalWidget(
                                  title: "Total Amount",
                                  amount: subtotalState.subtotal + 10.0,
                                ),
                              ],
                            );
                          }

                          return Column(
                            children: [
                              totalAndSubtoalWidget(
                                title: "Subtotal",
                                amount: state.subtotal,
                              ),

                              totalAndSubtoalWidget(
                                title: "Shipping",
                                amount: 10.0,
                              ),

                              SizedBox(height: 4.0),

                              DottedDashedLine(
                                height: 2,
                                width: double.infinity,
                                axis: Axis.horizontal,
                                dashColor: AppColors.grey,
                              ),

                              SizedBox(height: 4.0),

                              totalAndSubtoalWidget(
                                title: "Total Amount",
                                amount: state.subtotal + 10.0,
                              ),
                            ],
                          );
                        },
                      ),

                      //-------------continue btn-------------//
                      SizedBox(height: 40.0),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pushNamed(AppRouts.checkoutRoute);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: AppColors.white,
                            ),
                            child: Text('Checkout'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is CartError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text("Something went wrong"));
              }
            },
          );
        },
      ),
    );
  }

  Widget totalAndSubtoalWidget({
    required String title,
    required double amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
