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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getHomeData();
        return cubit;
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0), // مسافة بسيطة من أعلى الـ SafeArea
              // 1. Header الخاص بصفحة Home فقط
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22, // تكبير الصورة قليلاً لتكون أوضح
                        backgroundImage: AssetImage(
                          'assets/images/personal_photo.jpg',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Muhannd",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Let's go shopping!",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(
                        width: 16,
                      ), // مسافة بين أيقونة البحث والإشعارات
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_outlined),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20.0), // مسافة مناسبة قبل الـ TabBar
              // 2. الـ TabBar
              TabBar(
                controller: _tabController,
                unselectedLabelColor: AppColors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: 'Home'),
                  Tab(text: 'Category'),
                ],
              ),

              const SizedBox(height: 16.0), // مسافة بين الـ TabBar والمحتوى
              // 3. المحتوى
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [HomeTabBarView(), CategoryTabView()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
