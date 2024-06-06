import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/modal/product_modal.dart';
import 'package:pms/network/api_endpoint.dart';
import 'package:pms/network/api_service.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

final APIService _apiService = APIService();

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductInitial()) {
    on<AddProductSubmit>(
        (event, emit) => _onSubmitt(event, emit, state as AddProductInitial));

    on<AddProductSubmitEdit>((event, emit) =>
        _onSubmittEdit(event, emit, state as AddProductInitial));

    on<AddProductSelectCategory>(
        (event, emit) => _onselect(event, emit, state as AddProductInitial));

    on<AddProductEdit>((event, emit) =>
        _onEditInitEvent(event, emit, state as AddProductInitial));
  }

  void _onSubmitt(
    AddProductSubmit event,
    Emitter<AddProductState> emit,
    AddProductInitial currState,
  ) async {
    emit(currState.copywith(loading: true));
    try {
      final response = await _apiService.request(
          '${ApiEndPoint.kGetProducts}/add', METHOD.POST, event.map);

      if (response != null) {
        emit(AddProductSuccess(message: "Product added successfully"));
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

  void _onSubmittEdit(
    AddProductSubmitEdit event,
    Emitter<AddProductState> emit,
    AddProductInitial currState,
  ) async {
    emit(currState.copywith(loading: true));
    try {
      final response = await _apiService.request(
          '${ApiEndPoint.kGetProducts}/${currState.productId}',
          METHOD.PUT,
          event.map);

      if (response != null) {
        emit(AddProductSuccess(message: "Product edited successfully"));
        emit(currState.copywith(loading: false));
      } else {
        emit(AddProductError(message: "Error editing product."));
        emit(currState.copywith(loading: false));
      }
    } catch (e) {
      emit(AddProductError(message: "Error editing product."));
      emit(currState.copywith(loading: false));
    }
  }

  void _onEditInitEvent(AddProductEdit event, Emitter<AddProductState> emit,
      AddProductInitial currState) async {
    emit(AddProductEditState(product: event.product));
    emit(currState.copywith(productId: "${event.product.id ?? ""}"));
  }

  void _onselect(AddProductSelectCategory event, Emitter<AddProductState> emit,
      AddProductInitial currState) async {
    emit(currState.copywith(selectdCategory: event.selectedItem));
  }
}
