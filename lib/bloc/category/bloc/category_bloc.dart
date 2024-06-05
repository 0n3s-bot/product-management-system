import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/modal/product_modal.dart';
import 'package:pms/network/api_endpoint.dart';
import 'package:pms/network/api_service.dart';

part 'category_event.dart';
part 'category_state.dart';

final APIService _apiService = APIService();

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryInitEvent>(
        (event, emit) => _onEvent(event, emit, state as CategoryInitial));
  }

  void _onEvent(CategoryInitEvent event, Emitter<CategoryState> emit,
      CategoryInitial currState) async {
//
    List<ProductModal>? product;

    emit(currState.copyWith(loading: true));
    try {
      int page = (currState.pages ?? 0) + 1;
      product = await _getProduct(pages: page, slug: event.slug);

      emit(currState.copyWith(
        loading: false,
        pages: page,
        productList: product,
      ));
      //
    } catch (e) {
      emit(CategoryError(message: "Something Went wrong"));

      log(e.toString());

      emit(currState.copyWith(loading: false));
    }
    //
  }

  Future<List<ProductModal>?> _getProduct(
      {String? slug, required int pages}) async {
    final misc = "?skip=0&limit=${pages * 10}";
    try {
      final response = await _apiService.request(
          "${ApiEndPoint.kGetProducts}/category/$slug", METHOD.GET, null);

      if (response != null && response.data != null) {
        List<ProductModal>? cate =
            ProductModal.fromJsonList(response.data['products']);

        return cate;
      } else {
        return Future.error('Something went wrong');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
