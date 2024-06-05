import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_router/app_router.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/bloc/category/bloc/category_bloc.dart';
import 'package:pms/modal/category_modal.dart';
import 'package:pms/modal/product_modal.dart';
import 'package:pms/widget/error_image_builder.dart';

class CategoryItemsScreen extends StatefulWidget {
  final CategoryModal category;
  const CategoryItemsScreen({super.key, required this.category});

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  @override
  Widget build(BuildContext context) {
    double screnWidth = MediaQuery.sizeOf(context).width;
    double boxwidth = MediaQuery.orientationOf(context).index == 0
        ? (screnWidth - 3 * 16) / 2
        : (screnWidth - 5 * 16) / 4;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Category",
              style: CustomTextStyle.appBarTitleStyle,
            ),
            Text(
              widget.category.name ?? "",
              style: CustomTextStyle.appBarTitleStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state) {
            case CategoryInitial():
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Text("data"),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        for (ProductModal product in state.productList ?? [])
                          _buildProductCard(
                            product: product,
                            width: boxwidth,
                            onTap: () {
                              context.pushNamed(AppRouteName.productView,
                                  extra: product);
                            },
                          )
                        // Text(product.title ?? "")
                      ],
                    ),
                  ],
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

Widget _buildProductCard(
    {required ProductModal product,
    required double width,
    void Function()? onTap}) {
  double discount = product.discountPercentage ?? 0.0;
  double price = product.price ?? 0.0;
  double discountedAmount = price - (discount / 100) * price;

  return Card(
    color: AppColors.kwhiteColor,
    margin: EdgeInsets.zero,
    child: InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail ?? "",
                width: width,
                height: width,
                errorWidget: (context, url, error) => buildErrorImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Text(
                      product.title ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: CustomTextStyle.categoryTitleStyle.copyWith(
                        color: AppColors.kMatteBlack,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '\$ ${discountedAmount.toStringAsFixed(2)}',
                    style: CustomTextStyle.cardPriceStyle,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$ ${product.price ?? "0.0"}',
                        style: CustomTextStyle.carddateStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        ' -${product.discountPercentage}%',
                        style: CustomTextStyle.carddateStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
