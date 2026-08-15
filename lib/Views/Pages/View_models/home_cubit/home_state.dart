part of 'home_cubit.dart';

//super class
sealed class HomeState {}

final class HomeCubitInitial extends HomeState {}

//when loading
final class HomeLoading extends HomeState {}

//when success
final class HomeLoaded extends HomeState {
  HomeLoaded({required this.CarouselItems, required this.products});

  final List<HomeCarouselItemModel> CarouselItems;
  final List<ProductItemModel> products;
}

final class HomeError extends HomeState {
  HomeError({required this.message});

  final String message;
}
