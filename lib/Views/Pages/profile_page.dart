import 'package:ecommerce_app/Views/Pages/View_models/Auth/auth_cubit.dart'
    show AuthCubit, AuthState, AuthLoggingOutError, AuthLoggingOut;
import 'package:ecommerce_app/Views/Pages/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. عنوان الصفحة مع أيقونة الإعدادات على اليمين
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. كارت معلومات المستخدم افقياً
              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(
                      'assets/images/personal_photo.jpg',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Muhannd',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'muhanndhatem932@gmail.com',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3. قائمة الخيارات كروت مجتمعة
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildListItem(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 50),
                    _buildListItem(
                      icon: Icons.inventory_2_outlined,
                      title: 'My Orders',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 50),
                    _buildListItem(
                      icon: Icons.favorite_border,
                      title: 'Favorite',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 50),
                    _buildListItem(
                      icon: Icons.location_on_outlined,
                      title: 'My Addresses',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 50),
                    _buildListItem(
                      icon: Icons.payment_outlined,
                      title: 'Payment Methods',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Spacer(),
              // 4. زر خروج (Logout Button)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: BlocConsumer<AuthCubit, AuthState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is AuthLoggingOutError ||
                      current is AuthLoggingOut,
                  listener: (context, state) {
                    if (state is AuthLoggingOut) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouts.loginRoute,
                        (route) => false,
                      );
                    } else if (state is AuthLoggingOutError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  buildWhen: (previous, current) => current is AuthLoggingOut,
                  builder: (context, state) {
                    if (state is AuthLoggingOut) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return ListTile(
                      onTap: () async => await cubit.logout(),
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.red,
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

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
    );
  }
}
