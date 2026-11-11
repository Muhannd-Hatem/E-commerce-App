import 'package:ecommerce_app/Views/Pages/View_models/Auth/auth_cubit.dart';
import 'package:ecommerce_app/Views/Pages/View_models/passord.dart/password_visibility_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/lablel_with_text_field.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/main_bottom.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/social_media_bottom.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

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
                    "Login Account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please, login with registered account!',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
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
                        prefixIcon: Icons.lock_outline,
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

                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forget Password'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen: (previous, current) => current is AuthDone,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.pushNamed(context, AppRouts.homeRoute);
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
                        return MainBottom(isloading: true);
                      }
                      return MainBottom(
                        text: 'Login',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.loginWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
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
                            Navigator.pushNamed(
                              context,
                              AppRouts.registerRoute,
                            );
                          },
                          child: const Text('Don\'t have an account? Register'),
                        ),
                        Text(
                          'Or using other services',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 15),
                        BlocConsumer<AuthCubit, AuthState>(
                          listenWhen: (previous, current) =>
                              current is GoogleAuthenticationDone ||
                              current is GoogleAuthenticationError ||
                              current is GoogleAuthenticating,
                          listener: (context, state) {
                            if (state is GoogleAuthenticationDone) {
                              Navigator.pushNamed(context, AppRouts.homeRoute);
                            } else if (state is GoogleAuthenticationError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is GoogleAuthenticating ||
                              current is GoogleAuthenticationDone ||
                              current is GoogleAuthenticationError,
                          builder: (context, state) {
                            if (state is GoogleAuthenticating) {
                              return SocialMediaBottom(isLoading: true);
                            }
                            return SocialMediaBottom(
                              text: 'Login with Google',
                              img: 'assets/images/google_icon.png',
                              onTap: () async => cubit.authenticateWithGoogle(),
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,

                          listenWhen: (previous, current) =>
                              current is FacebookAuthenticationDone ||
                              current is FacebookAuthenticationError,

                          listener: (context, state) {
                            if (state is FacebookAuthenticationDone) {
                              Navigator.pushNamed(context, AppRouts.homeRoute);
                            } else if (state is FacebookAuthenticationError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is FacebookAuthenticating ||
                              current is FacebookAuthenticationDone ||
                              current is FacebookAuthenticationError,
                          builder: (context, state) {
                            if (state is FacebookAuthenticating) {
                              return SocialMediaBottom(isLoading: true);
                            }
                            return SocialMediaBottom(
                              text: 'Login with Facebook',
                              img: 'assets/images/Facebook_Logo.png',
                              onTap: () async =>
                                  cubit.authenticateWithFacebook(),
                            );
                          },
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
