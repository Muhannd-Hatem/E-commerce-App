import 'package:ecommerce_app/Views/Pages/View_models/Auth/auth_cubit.dart'
    show AuthCubit, AuthState, AuthDone, AuthLoading, AuthError;
import 'package:ecommerce_app/Views/Pages/View_models/passord.dart/password_visibility_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/lablel_with_text_field.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/main_bottom.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/social_media_bottom.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return BlocProvider(
      create: (context) => PasswordVisibilityCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Create New Account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please, create account with registered account!',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                  ),
                  const SizedBox(height: 16),
                  LabelWithTextField(
                    label: 'User Name',
                    controller: userNameController,
                    prefixIcon: Icons.person_outline,
                    hintText: 'Enter your user name',
                  ),
                  const SizedBox(height: 16),
                  LabelWithTextField(
                    label: 'Email',
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                    hintText: 'Enter your email',
                  ),
                  const SizedBox(height: 24),

                  // ربط حقل كلمة السر بـ Cubit
                  BlocBuilder<PasswordVisibilityCubit, bool>(
                    builder: (context, isPasswordHidden) {
                      return LabelWithTextField(
                        label: 'Password',
                        controller: passwordController,
                        prefixIcon: Icons.password,
                        hintText: 'Enter your password',
                        isPassword: true,
                        obscureText: isPasswordHidden,
                        onTogglePassword: () {
                          context
                              .read<PasswordVisibilityCubit>()
                              .toggleVisibility();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen: (previous, current) =>
                        current is AuthDone || current is AuthError,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(AppRouts.homeRoute);
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AuthLoading ||
                        current is AuthError ||
                        current is AuthDone,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return MainBottom(
                        text: 'Create Account',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.registerWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                              userNameController.text,
                            );

                            // Navigator.of(context).pushNamed(AppRouts.loginRoute);
                          }
                        },
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('You have an account? Login'),
                        ),
                        Text(
                          'Or using other services',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 15),
                        SocialMediaBottom(
                          text: 'Login with Google',
                          img: 'assets/images/google_icon.png',
                          onTap: () {},
                        ),
                        const SizedBox(height: 15),
                        SocialMediaBottom(
                          text: 'Login with Facebook',
                          img: 'assets/images/Facebook_Logo.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
