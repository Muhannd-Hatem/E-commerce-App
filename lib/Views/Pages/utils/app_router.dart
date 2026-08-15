import 'package:ecommerce_app/Views/Pages/View_models/home_cubit/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/custom_bottom_navbar.dart';
import 'package:ecommerce_app/Views/Pages/product_details_page.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouts.homeRoute:
        return MaterialPageRoute(builder: (context) => CustomBottomNavBar());

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
