import 'package:ecommerce_app/Views/Pages/View_models/add_new_cart_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/lablel_with_text_field.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCart extends StatefulWidget {
  const AddNewCart({super.key});

  @override
  State<AddNewCart> createState() => _AddNewCartState();
}

class _AddNewCartState extends State<AddNewCart> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Cart')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              LabelWithTextField(
                label: 'Card Number',
                controller: _cardNumberController,
                hintText: 'Enter Card Number',
                prefixIcon: Icons.credit_card,
              ),

              const SizedBox(height: 16.0),

              LabelWithTextField(
                label: 'Card Holder Name',
                controller: _cardHolderNameController,
                hintText: 'Enter Holder Name',
                prefixIcon: Icons.person_outlined,
              ),

              const SizedBox(height: 16.0),

              LabelWithTextField(
                label: 'Expiration Date',
                controller: _expiryDateController,
                hintText: 'Enter MM/YY',
                prefixIcon: Icons.date_range_outlined,
              ),

              const SizedBox(height: 16.0),

              LabelWithTextField(
                label: 'CVV',
                controller: _cvvController,
                hintText: 'Enter CVV',
                prefixIcon: Icons.password_outlined,
              ),

              Spacer(),

              SizedBox(
                width: double.infinity,
                child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is AddNewCartSuccess ||
                      current is AddNewCartFailure,
                  listener: (context, state) {
                    if (state is AddNewCartSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cart added successfully!')),
                      );
                    } else if (state is AddNewCartFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is AddNewCartLoading ||
                      current is AddNewCartSuccess ||
                      current is AddNewCartFailure,
                  builder: (context, state) {
                    if (state is AddNewCartLoading) {
                      return ElevatedButton(
                        onPressed: null,
                        child: const CircularProgressIndicator.adaptive(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.addNewCart(
                            _cardNumberController.text,
                            _cardHolderNameController.text,
                            _expiryDateController.text,
                            _cvvController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: const Text(
                        'Add Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
