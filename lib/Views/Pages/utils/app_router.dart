import 'package:ecommerce_app/Views/Pages/View_models/Auth/auth_cubit.dart';
import 'package:ecommerce_app/Views/Pages/View_models/add_new_cart_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/Views/Pages/View_models/choose_loacation_cubit/choose_location_cubit.dart';
import 'package:ecommerce_app/Views/Pages/View_models/home_cubit/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/add_new_cart.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/custom_bottom_navbar.dart';
import 'package:ecommerce_app/Views/Pages/checkout_page.dart';
import 'package:ecommerce_app/Views/Pages/choose_location_page.dart';
import 'package:ecommerce_app/Views/Pages/login_page.dart';
import 'package:ecommerce_app/Views/Pages/product_details_page.dart';
import 'package:ecommerce_app/Views/Pages/register_page.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouts.homeRoute:
        return MaterialPageRoute(builder: (context) => CustomBottomNavBar());

      case AppRouts.checkoutRoute:
        return MaterialPageRoute(builder: (context) => CheckoutPage());

      case AppRouts.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginPage(),
          ),
        );

      case AppRouts.registerRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: RegisterPage(),
          ),
        );

      case AppRouts.chooseLocationRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final cubit = ChooseLocationCubit();
              cubit.fetchLocations();
              return cubit;
            },
            child: ChooseLocationPage(),
          ),
        );

      case AppRouts.addNewCartRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => PaymentMethodsCubit(),
            child: AddNewCart(),
          ),
        );

      case AppRouts.productDetailsRoute:
        final String productId = settings.arguments as String;

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final cubit = ProductDetailsCubit();
              cubit.getProductDetails(productId);
              return cubit;
            },
            child: ProductDetailsPage(productId: productId),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text("No Routs Define for ${settings.name}")),
          ),
        );
    }
  }
}
