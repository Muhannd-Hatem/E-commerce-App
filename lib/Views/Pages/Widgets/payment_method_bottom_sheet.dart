import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Views/Pages/View_models/add_new_cart_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/main_bottom.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentMethodsCubit = BlocProvider.of<PaymentMethodsCubit>(context);

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Payment Methods',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Payment List
              BlocBuilder(
                bloc: paymentMethodsCubit,
                buildWhen: (previous, current) =>
                    current is FetchedPaymentMethods ||
                    current is FetchPaymentMethodsFailure ||
                    current is FetchingPaymentMethods,
                builder: (context, state) {
                  if (state is FetchingPaymentMethods) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  } else if (state is FetchPaymentMethodsFailure) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: Text(state.message)),
                    );
                  } else if (state is FetchedPaymentMethods) {
                    final paymentCarts = state.dummyPaymentCarts;
                    return BlocBuilder<
                      PaymentMethodsCubit,
                      PaymentMethodsState
                    >(
                      bloc: paymentMethodsCubit,
                      buildWhen: (previous, current) =>
                          current is PaymentMethodChosen,
                      builder: (context, chosenState) {
                        final selectedId = chosenState is PaymentMethodChosen
                            ? chosenState.chosenPayment.id
                            : paymentMethodsCubit.selectedPaymentId;

                        return RadioGroup<String>(
                          groupValue: selectedId,
                          onChanged: (id) {
                            if (id != null) {
                              paymentMethodsCubit.changePaymentMethod(id);
                            }
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: paymentCarts.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final paymentCart = paymentCarts[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    paymentMethodsCubit.changePaymentMethod(
                                      paymentCart.id,
                                    );
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 4.0,
                                  ),
                                  leading: CachedNetworkImage(
                                    imageUrl:
                                        'https://pngimg.com/uploads/mastercard/mastercard_PNG16.png',
                                    height: 64,
                                    width: 64,
                                    fit: BoxFit.fill,
                                  ),
                                  title: const Text(
                                    'MasterCard',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Text(
                                    paymentCart.cardNumber,
                                    style: const TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                  trailing: Radio<String>(
                                    value: paymentCart.id,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No Payment Methods'));
                  }
                },
              ),

              const SizedBox(height: 12),

              // Add New Card Button
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRouts.addNewCartRoute);
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grey2,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Add New Card',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Confirm Payment Button
              BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                bloc: paymentMethodsCubit,
                listenWhen: (previous, current) =>
                    current is ConfirmPaymentSuccess,
                buildWhen: (previous, current) =>
                    current is ConfirmPaymentLoading ||
                    current is ConfirmPaymentSuccess ||
                    current is ConfirmPaymentFailure,
                listener: (context, state) {
                  if (state is ConfirmPaymentSuccess) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is ConfirmPaymentLoading) {
                    return MainBottom(isloading: true, onTap: null);
                  }
                  return MainBottom(
                    text: 'Confirm Payment',
                    onTap: () {
                      paymentMethodsCubit.confirmPaymentMethod();
                    },
                    width: double.infinity,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
