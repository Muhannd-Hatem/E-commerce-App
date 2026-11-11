import 'package:ecommerce_app/Views/Pages/View_models/choose_loacation_cubit/choose_location_cubit.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/location_item_card.dart';
import 'package:ecommerce_app/Views/Pages/Widgets/main_bottom.dart';
import 'package:ecommerce_app/Views/Pages/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({Key? key}) : super(key: key);

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    locationController.dispose(); // تنظيف المحرر عند إغلاق الصفحة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChooseLocationCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Address'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose your location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Let\'s find an unforgettable event. Choose a location below to get started.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'Write location: city-country',
                  fillColor: AppColors.grey3,
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.grey3,
                  ),
                  suffixIcon:
                      BlocConsumer<ChooseLocationCubit, ChooseLocationState>(
                        bloc: cubit,
                        buildWhen: (previous, current) =>
                            current is AddingLocation ||
                            current is AddLocationFailure ||
                            current is AddedLocation,
                        listenWhen: (previous, current) =>
                            current is AddedLocation ||
                            current is ConfirmAddressLoaded,
                        listener: (context, state) {
                          if (state is AddedLocation) {
                            locationController.clear();
                          } else if (state is ConfirmAddressLoaded) {
                            Navigator.of(context).pop(); // تم إضافة الأقواس ()
                          }
                        },
                        builder: (context, state) {
                          if (state is AddingLocation) {
                            return const CircularProgressIndicator.adaptive();
                          } else if (state is AddLocationFailure) {
                            return const Icon(
                              Icons.error,
                              color: AppColors.red,
                            );
                          }

                          return IconButton(
                            icon: const Icon(Icons.add, color: AppColors.grey3),
                            onPressed: () {
                              if (locationController.text.isNotEmpty) {
                                cubit.addLocation(locationController.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter a location'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Select Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is FetchedLocations ||
                    current is FetchingLocations ||
                    current is FetchLocationFailure,
                builder: (context, state) {
                  if (state is FetchLocationFailure) {
                    return Center(child: Text(state.message));
                  } else if (state is FetchedLocations) {
                    final locations = state.locations; // تغيير الاسم إلى الجمع
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: locations.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return BlocBuilder<
                          ChooseLocationCubit,
                          ChooseLocationState
                        >(
                          bloc: cubit,
                          buildWhen: (previous, current) =>
                              current is LocationChosen,
                          builder: (context, state) {
                            if (state is LocationChosen) {
                              final chosenLocation = state.location;
                              return LocationItemCard(
                                onTap: () {
                                  cubit.selectLocation(locations[index].id);
                                },
                                location: locations[index],
                                borderColor:
                                    chosenLocation.id == locations[index].id
                                    ? AppColors.primary
                                    : AppColors.grey,
                              );
                            }
                            return LocationItemCard(
                              onTap: () {
                                cubit.selectLocation(locations[index].id);
                              },
                              location: locations[index],
                            );
                          },
                        );
                      },
                    );
                  } else if (state is FetchingLocations) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return const Text('No Locations Found');
                  }
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is ConfirmAddressLoading ||
                    current is ConfirmAddressFailure ||
                    current is ConfirmAddressLoaded,
                builder: (context, state) {
                  if (state is ConfirmAddressLoading) {
                    return MainBottom(isloading: true, onTap: () {});
                  } else if (state is ConfirmAddressFailure) {
                    return Center(child: Text(state.message));
                  } else if (state is ConfirmAddressLoaded) {
                    return const Text('Address Confirmed');
                  } else {
                    return MainBottom(
                      text: 'Confirm Address',
                      onTap: () {
                        cubit.confirmAddress();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
