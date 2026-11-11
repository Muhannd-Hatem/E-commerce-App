part of 'home_cubit.dart';

//super class
sealed class HomeState {}

final class HomeCubitInitial extends HomeState {}

//when loading
final class HomeLoading extends HomeState {}
//when success
final class HomeLoaded extends HomeState {
  HomeLoaded({required this.carouselItems, required this.products});

  final List<HomeCarouselItemModel> carouselItems;
  final List<ProductItemModel> products;
}

final class HomeError extends HomeState {
  HomeError(this.message);

  final String message;
}
