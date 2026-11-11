import 'package:ecommerce_app/Views/Pages/View_models/Auth/auth_cubit.dart';
import 'package:ecommerce_app/Views/Pages/View_models/cart_cubit/cart_cubit.dart';

import 'package:ecommerce_app/Views/Pages/utils/app_router.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(create: (context) => CartCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.checkCurrentUser();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          final authcubit = BlocProvider.of<AuthCubit>(context);

          return BlocBuilder<AuthCubit, AuthState>(
            bloc: authcubit,
            buildWhen: (previous, current) =>
                current is AuthDone || current is AuthInitial,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primaryColor: Colors.deepPurple),
                initialRoute: state is AuthDone
                    ? AppRouts.homeRoute
                    : AppRouts.loginRoute,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
