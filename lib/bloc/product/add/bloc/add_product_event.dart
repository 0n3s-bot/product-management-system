part of 'add_product_bloc.dart';

sealed class AddProductEvent extends Equatable {}

class AddProductSubmit extends AddProductEvent {
  final Map map;

  AddProductSubmit({required this.map});
  @override
  List<Object?> get props => [];
}

class AddProductSubmitEdit extends AddProductEvent {
  final Map map;

  AddProductSubmitEdit({required this.map});
  @override
  List<Object?> get props => [];
}
class AddProductEdit extends AddProductEvent {
  final ProductModal product;

  AddProductEdit({required this.product});
  @override
  List<Object?> get props => [];
}

class AddProductSelectCategory extends AddProductEvent {
  final String selectedItem;

  AddProductSelectCategory({required this.selectedItem});
  @override
  List<Object?> get props => [selectedItem];
}
