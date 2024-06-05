import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/modal/product_modal.dart';
import 'package:pms/network/api_endpoint.dart';
import 'package:pms/network/api_service.dart';

part 'search_event.dart';
part 'search_state.dart';

final APIService _apiService = APIService();

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchInitEvent>(
        (event, emit) => _onSerch(event, emit, state as SearchInitial));
  }

  void _onSerch(SearchInitEvent event, Emitter<SearchState> emit,
      SearchInitial currState) async {
    List<ProductModal>? productList;
    final misc = "?q=${event.item}";

    if (event.item.isNotEmpty && event.item.length > 1) {
      emit(currState.copyWith(searching: true));
      // try {

      try {
        final response = await _apiService.request(
            "${ApiEndPoint.kGetProducts}/search$misc", METHOD.GET, null);

        if (response != null && response.data != null) {
          productList = ProductModal.fromJsonList(response.data['products']);
          int? total = response.data['total'];
          int? shown = response.data['limit'];

          emit(
            currState.copyWith(
                productList: productList,
                searching: false,
                total: total,
                shown: shown),
          );
        } else {
          return Future.error('Something went wrong');
        }
      } catch (e) {
        return Future.error(e);
      }

      // } catch (e) {
      //   emit(SearchError(message: "message"));
      //   emit(currState.copyWith(searching: false));
      // }
    } else {
      emit(
        currState.copyWith(productList: [], searching: false),
      );
    }
  }

  Future<List<ProductModal>?> _getProduct({String? item}) async {
    final misc = "?q=$item";
    try {
      final response = await _apiService.request(
          "${ApiEndPoint.kGetProducts}/search$misc", METHOD.GET, null);

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
