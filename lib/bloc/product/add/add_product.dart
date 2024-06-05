import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_cache/shared_pref/shared_pref.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/bloc/product/add/bloc/add_product_bloc.dart';
import 'package:pms/modal/category_modal.dart';
import 'package:pms/utills/custom_toast.dart';
import 'package:pms/utills/form_validator.dart';
import 'package:pms/widget/custom_button.dart';
import 'package:pms/widget/custom_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _weigthController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _warrantyController = TextEditingController();
  final TextEditingController _shippingController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  final TextEditingController _returnController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<CategoryModal>? categories = CustomSharedPreference.getCategories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          //
          if (state is AddProductError) {
            CustomToast.showMessage(state.message);
          }
          if (state is AddProductSuccess) {
            context.pop();
            CustomToast.showMessage(state.message);
          }
        },
        builder: (context, state) {
          switch (state) {
            case AddProductInitial():
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        title: 'Title',
                        showTitle: true,
                        lines: 1,
                        controller: _titleController,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Title'),
                      ),
                      CustomTextField(
                        title: 'Brand',
                        showTitle: true,
                        lines: 1,
                        controller: _brandController,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Brand'),
                      ),
                      CustomTextField(
                        title: 'SKU',
                        showTitle: true,
                        lines: 1,
                        controller: _skuController,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'SKU'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      requiredTitleWidget(title: "Category", isrequired: false),
                      const SizedBox(
                        height: 6,
                      ),
                      BuildSelectClassDropDown(
                        selectedValue: state.selectdCategory,
                        category: categories ?? [],
                        onChanged: (value) {
                          context.read<AddProductBloc>().add(
                              AddProductSelectCategory(selectedItem: value!));
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                (MediaQuery.sizeOf(context).width - 32) * 0.46,
                            child: CustomTextField(
                              title: 'Price',
                              showTitle: true,
                              lines: 1,
                              keyboardTyp: TextInputType.number,
                              controller: _priceController,
                              validator: (value) => Validator.validateField(
                                  value: value!, fieldName: 'Price'),
                            ),
                          ),
                          SizedBox(
                            width:
                                (MediaQuery.sizeOf(context).width - 32) * 0.46,
                            child: CustomTextField(
                              title: 'Discount',
                              showTitle: true,
                              lines: 1,
                              keyboardTyp: TextInputType.number,
                              controller: _discountController,
                              validator: (value) => Validator.validateField(
                                  value: value!, fieldName: 'Discount'),
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        title: 'Stock',
                        showTitle: true,
                        lines: 1,
                        keyboardTyp: TextInputType.number,
                        controller: _stockController,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Stock'),
                      ),
                      CustomTextField(
                        title: 'Weight',
                        showTitle: true,
                        lines: 1,
                        controller: _weigthController,
                        keyboardTyp: TextInputType.number,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Weight'),
                      ),
                      CustomTextField(
                        title: 'Description',
                        lines: 5,
                        showTitle: true,
                        controller: _descriptionController,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Description'),
                      ),
                      CustomTextField(
                        title: 'Warranty Information',
                        lines: 5,
                        showTitle: true,
                        controller: _warrantyController,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Warranty Information'),
                      ),
                      CustomTextField(
                        title: 'Shipping Information',
                        showTitle: true,
                        controller: _shippingController,
                        lines: 5,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Shipping Information'),
                      ),
                      CustomTextField(
                        title: 'Availability Status',
                        lines: 5,
                        showTitle: true,
                        controller: _availabilityController,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Availability Status'),
                      ),
                      CustomTextField(
                        title: 'Return policy',
                        lines: 5,
                        showTitle: true,
                        controller: _returnController,
                        validator: (value) => Validator.validateField(
                            value: value!, fieldName: 'Return policy'),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      customButton(
                        isLoading: state.loading,
                        title: "Add",
                        onPressed: () {
                          Map map = {
                            "title": _titleController.text.trim(),
                            "description": _descriptionController.text.trim(),
                            "category": state.selectdCategory,
                            "price": _priceController.text.trim(),
                            "discountPercentage":
                                _discountController.text.trim(),
                            "stock": _stockController.text.trim(),
                            "brand": _brandController.text.trim(),
                            "sku": _skuController.text.trim(),
                            "weight": _weigthController.text.trim(),
                            "warrantyInformation":
                                _warrantyController.text.trim(),
                            "shippingInformation":
                                _shippingController.text.trim(),
                            "availabilityStatus":
                                _availabilityController.text.trim(),
                            "returnPolicy": _returnController.text.trim(),
                          };

                          if (_formKey.currentState!.validate()) {
                            context
                                .read<AddProductBloc>()
                                .add(AddProductSubmit(map: map));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class BuildSelectClassDropDown extends StatefulWidget {
  final List<CategoryModal> category;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? selectedValue;
  const BuildSelectClassDropDown({
    super.key,
    required this.category,
    required this.onChanged,
    this.selectedValue,
    this.validator,
  });

  @override
  State<BuildSelectClassDropDown> createState() =>
      _BuildSelectClassDropDownState();
}

class _BuildSelectClassDropDownState extends State<BuildSelectClassDropDown> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      builder: (FormFieldState state) {
        return InputDecorator(
          // isFocused: true,
          isEmpty: widget.selectedValue == null || widget.selectedValue == "",
          // expands: true,

          decoration: InputDecoration(
            // prefixIcon: Icon(
            //   Icons.class_,
            //   color: AppColors.kPrimaryColor,
            // ),
            isDense: true,
            // errorText:
            //     state.value == null || state.value!.isEmpty ? "error" : null,
            // error: Text("err"),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.kPrimaryColor,
                width: 0.8,
              ),
            ),
            hintStyle: TextStyle(
              fontSize: 15,
              color: AppColors.kMatteBlack.withOpacity(0.8),
            ),
            hintText: "Plese Select Category",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.kPrimaryColor,
                width: 0.6,
              ),
            ),

            errorStyle:
                const TextStyle(color: Colors.redAccent, fontSize: 12.0),

            // hintText: 'Please select Class',
          ),
          // isEmpty: widget.selectedValue == null || widget.selectedValue == "",
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Theme.of(context).cardColor,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.kMatteBlack,
              ),
              value: widget.selectedValue,
              isDense: true,

              // hint: Text(
              //   'Please select Class',
              //   style: TextStyle(
              //     color: AppColors.kMatteBlack.withOpacity(0.8),
              //     fontSize: 15,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              isExpanded: true,
              onChanged: widget.onChanged,
              items: widget.category.map((CategoryModal value) {
                return DropdownMenuItem(
                  value: value.slug.toString(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      value.name ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.kMatteBlack,
                        fontWeight: FontWeight.w500,
                      ),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
