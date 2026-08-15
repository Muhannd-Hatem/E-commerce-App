import 'package:ecommerce_app/Views/Pages/View_models/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/category_tab_view.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/home_tab_view.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Header with profile picture and name
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/personal_photo.jpg',
                          ),
                          radius: 30,
                        ),
                        SizedBox(width: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Muhannd",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              "Let's go shopping!",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                TabBar(
                  controller: _tabController,
                  unselectedLabelColor: AppColors.grey,
                  tabs: [
                    Tab(text: 'Home'),
                    Tab(text: 'Category'),
                  ],
                ),

                const SizedBox(height: 24.0),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [HomeTabBarView(), CategoryTabView()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
