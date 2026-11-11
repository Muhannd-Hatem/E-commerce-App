import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:ecommerce_app/models/payment_cart_model.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentCartModel paymentCart;
  final VoidCallback onitemTaped;
  const PaymentMethodItem({
    super.key,
    required this.paymentCart,
    required this.onitemTaped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onitemTaped,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          border: Border.all(color: AppColors.grey),
        ),
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl:
                'https://pngimg.com/uploads/mastercard/mastercard_PNG16.png',
            height: 64,
            width: 64,
            fit: BoxFit.fill,
          ),

          title: Text('MasterCard'),
          subtitle: Text(paymentCart.cardNumber),
          trailing: Icon(Icons.chevron_right, color: AppColors.grey),
        ),
      ),
    );
  }
}
