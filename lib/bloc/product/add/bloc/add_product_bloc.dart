import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/network/api_endpoint.dart';
import 'package:pms/network/api_service.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

final APIService _apiService = APIService();

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductInitial()) {
    on<AddProductSubmit>(
        (event, emit) => _onSubmitt(event, emit, state as AddProductInitial));

    on<AddProductSelectCategory>(
        (event, emit) => _onselect(event, emit, state as AddProductInitial));
  }

  void _onSubmitt(
    AddProductSubmit event,
    Emitter<AddProductState> emit,
    AddProductInitial currState,
  ) async {
    try {
      final response = await _apiService.request(
          '${ApiEndPoint.kGetProducts}/add', METHOD.POST, event.map);

      if (response != null) {
        emit(AddProductSuccess(message: "ProductAdded Successfully"));
        emit(currState.copywith(loading: false));
      } else {
        emit(AddProductError(message: "Error Adding product."));
        emit(currState.copywith(loading: false));
      }
    } catch (e) {
      emit(AddProductError(message: "Error Adding product."));
      emit(currState.copywith(loading: false));
    }
  }

  void _onselect(AddProductSelectCategory event, Emitter<AddProductState> emit,
      AddProductInitial currState) async {
    emit(currState.copywith(selectdCategory: event.selectedItem));
  }
}
