part of 'choose_location_cubit.dart';

sealed class ChooseLocationState {}

final class ChooseLocationCubitInitial extends ChooseLocationState {}

final class FetchingLocations extends ChooseLocationState {}

final class FetchedLocations extends ChooseLocationState {
  final List<LocationModel> locations;
  FetchedLocations({required this.locations});
}

final class FetchLocationFailure extends ChooseLocationState {
  final String message;
  FetchLocationFailure({required this.message});
}

final class AddingLocation extends ChooseLocationState {}

final class AddedLocation extends ChooseLocationState {}

final class AddLocationFailure extends ChooseLocationState {
  final String message;
  AddLocationFailure({required this.message});
}

final class LocationChosen extends ChooseLocationState {
  final LocationModel location;

  LocationChosen({required this.location});
}

final class ConfirmAddressLoading extends ChooseLocationState {}

final class ConfirmAddressLoaded extends ChooseLocationState {}

final class ConfirmAddressFailure extends ChooseLocationState {
  final String message;
  ConfirmAddressFailure({required this.message});
}
