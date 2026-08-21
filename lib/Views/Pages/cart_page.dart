import 'package:ecommerce_app/Views/Pages/View_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/cart_item_widget.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<cartcubit, CartState>(
        bloc: BlocProvider.of<cartcubit>(context),
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
                ],
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
