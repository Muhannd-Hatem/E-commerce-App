import 'package:ecommerce_app/Views/Pages/View_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/Views/Pages/View_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:ecommerce_app/Views/Pages/home_page.dart';
import 'package:ecommerce_app/Views/Pages/cart_page.dart';
import 'package:ecommerce_app/Views/Pages/favorite_page.dart';
import 'package:ecommerce_app/Views/Pages/profile_page.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = cartcubit();
            cubit.getCartItems();
            return cubit;
          },
        ),

        BlocProvider(
          create: (context) {
            final cubit = HomeCubit();
            cubit.getHomeData();
            return cubit;
          },
        ),
      ],
      child: PersistentTabView(
        controller: _controller,
        tabs: [
          PersistentTabConfig(
            screen: const HomePage(),
            item: ItemConfig(
              icon: const Icon(Icons.home_outlined),
              title: 'Home',
              activeForegroundColor: Theme.of(context).primaryColor,
            ),
          ),

          PersistentTabConfig(
            screen: const CartPage(),
            item: ItemConfig(
              icon: const Icon(Icons.shopping_cart_outlined),
              title: 'My Orders',
              activeForegroundColor: Theme.of(context).primaryColor,
            ),
          ),

          PersistentTabConfig(
            screen: const FavoritePage(),
            item: ItemConfig(
              icon: const Icon(Icons.favorite_border),
              title: 'Favorite',
              activeForegroundColor: Theme.of(context).primaryColor,
            ),
          ),

          PersistentTabConfig(
            screen: const ProfilePage(),
            item: ItemConfig(
              icon: const Icon(Icons.person_2_outlined),
              title: 'Profile',
              activeForegroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style6BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: const NavBarDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
