import 'package:ecommerce_app/models/location_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationCubitInitial());
  String? selectedLocationId = locations.first.id;

  void fetchLocations() {
    emit(FetchingLocations());

    Future.delayed(const Duration(seconds: 1), () {
      emit(FetchedLocations(locations: locations));
    });
  }

  void addLocation(String location) {
    emit(AddingLocation());

    Future.delayed(const Duration(seconds: 1), () {
      final splitLocation = location.split('-');
      final city = splitLocation[0].trim();
      final country = splitLocation.length > 1 ? splitLocation[1].trim() : '';
      final locationItem = LocationModel(
        id: DateTime.now().toIso8601String(),
        city: city,
        country: country,
      );
      locations.add(locationItem);
      emit(AddedLocation());
      emit(FetchedLocations(locations: locations));
    });
  }

  void selectLocation(String id) {
    selectedLocationId = id;
    final choosenLocation = locations.firstWhere(
      (location) => location.id == selectedLocationId,
    );
    emit(LocationChosen(location: choosenLocation));
  }

  void confirmAddress() {
    emit(ConfirmAddressLoading());
    Future.delayed(const Duration(seconds: 1), () {
      var chosenAddress = locations.firstWhere(
        (location) => location.id == selectedLocationId,
      );

      var previousAddress = locations.firstWhere(
        (location) => location.isChosen == true,
        orElse: () => locations.first,
      );
      chosenAddress = chosenAddress.copyWith(isChosen: true);
      previousAddress = previousAddress.copyWith(isChosen: false);

      final previousIndex = locations.indexWhere(
        (location) => location.id == previousAddress.id,
      );
      final chosenIndex = locations.indexWhere(
        (location) => location.id == chosenAddress.id,
      );
      locations[previousIndex] = previousAddress;
      locations[chosenIndex] = chosenAddress;
      emit(ConfirmAddressLoaded());
    });
  }
}
