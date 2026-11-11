import 'package:ecommerce_app/services/home_serveces.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/home_carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());
  final HomeServeces = HomeServecesImpl();

  Future<void> getHomeData() async {
    try {
      final products = await HomeServeces.fetchProducts();
      final carouselItem = homeCarouselItems;
      emit(HomeLoaded(carouselItems: carouselItem, products: products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
    //future.delayed(const Duration(secound: 1), {
    // emit(HomeLoading());
    // final products = HomeServeces.fetchProduct();
    // Future.delayed(Duration(seconds: 1), () {
    //   emit(HomeLoaded(carouselItems: homeCarouselItems, products: products));
    // });
  }
}
