import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/modal/category_modal.dart';
import 'package:pms/modal/product_modal.dart';
import 'package:pms/network/api_endpoint.dart';
import 'package:pms/network/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

final APIService _apiService = APIService();

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitEvent>(
        (event, emit) => _oninit(event, emit, state as HomeInitial));
    on<HomeTriggerShowEvent>(
        (event, emit) => _ontTrigger(event, emit, state as HomeInitial));
    on<HomeLoadMoreEvent>(
        (event, emit) => _onLoadMore(event, emit, state as HomeInitial));
  }

  void _oninit(HomeInitEvent event, Emitter<HomeState> emit,
      HomeInitial currState) async {
    List<CategoryModal>? cate;
    List<ProductModal>? productList;
    emit(currState.copyWith(loading: true));
    try {
      List<CategoryModal> homecate = [];
      cate = await _getCategory();
      if (cate != null) {
        for (var i = 0; i < 5; i++) {
          homecate.add(cate[i]);
        }
      }
      int page = (currState.page ?? 0) + 1;

      productList = await _getProduct(pages: page);

      emit(
        currState.copyWith(
            loading: false,
            categoryList: homecate,
            originalCateList: cate,
            productList: productList,
            page: page),
      );
    } catch (e) {
      emit(HomeError());

      log(e.toString());

      emit(currState.copyWith(loading: false));
    }
  }

  void _ontTrigger(HomeTriggerShowEvent event, Emitter<HomeState> emit,
      HomeInitial currState) async {
    List<CategoryModal>? homecate = [], cate = currState.originalCateList;

    bool showVal = !currState.showCategory;

    log(showVal.toString());
    if (showVal) {
      homecate = cate;
    } else {
      if (cate != null) {
        for (var i = 0; i < 5; i++) {
          homecate.add(cate[i]);
        }
      }
    }

    emit(currState.copyWith(
      showCategory: showVal,
      categoryList: homecate,
    ));
  }

  void _onLoadMore(HomeLoadMoreEvent event, Emitter<HomeState> emit,
      HomeInitial currState) async {
    if (currState.loadingMore == false) {
      List<ProductModal>? productList;
      emit(currState.copyWith(loadingMore: true));
      try {
        int page = (currState.page ?? 0) + 1;

        productList = await _getProduct(pages: page);
        emit(
          currState.copyWith(
              loadingMore: false, productList: productList, page: page),
        );
      } catch (e) {
        emit(HomeError());
        emit(currState.copyWith(loadingMore: false));
      }
    }
  }

  Future<List<CategoryModal>?> _getCategory() async {
    try {
      final response = await _apiService.request(
          ApiEndPoint.kgetCategories, METHOD.GET, null);

      if (response != null && response.data != null) {
        List<CategoryModal>? cate = CategoryModal.fromJsonList(response.data);

        return cate;
      } else {
        return Future.error('Something went wrong');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ProductModal>?> _getProduct({required int pages}) async {
    final misc = "?skip=0&limit=${pages * 10}";
    try {
      final response = await _apiService.request(
          "${ApiEndPoint.kGetProducts}$misc", METHOD.GET, null);

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
