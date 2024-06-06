import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_router/app_router.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/bloc/search/bloc/search_bloc.dart';
import 'package:pms/modal/product_modal.dart';
import 'package:pms/widget/custom_textfield.dart';
import 'package:pms/widget/error_image_builder.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchError) {}
      },
      builder: (context, state) {
        final bloc = context.read<SearchBloc>();
        switch (state) {
          case SearchInitial():
            return SearchingWidget(
              bloc: bloc,
              state: state,
            );
          default:
            return Scaffold(
              appBar: AppBar(),
            );
        }
      },
    );
  }
}

class SearchingWidget extends StatefulWidget {
  final bloc;
  final SearchInitial state;
  const SearchingWidget({super.key, required this.bloc, required this.state});
  @override
  State<SearchingWidget> createState() => _SearchingWidgetState();
}

class _SearchingWidgetState extends State<SearchingWidget> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screnWidth = MediaQuery.sizeOf(context).width;
    double boxwidth = MediaQuery.orientationOf(context).index == 0
        ? (screnWidth - 3 * 16) / 2
        : (screnWidth - 5 * 16) / 4;

    return Scaffold(
      appBar: AppBar(
        // foregroundColor: AppColors.kwhiteColor,
        // backgroundColor: AppColors.kPrimaryColor,
        toolbarHeight: 70,
        leadingWidth: 50,
        titleSpacing: 6,
        notificationPredicate: (notification) {
          return true;
        },

        title: CustomTextField(
          fillColor: Colors.white,
          autofocus: true,
          upperGAp: 0,
          bottomgap: 8,
          hintText: "eg:smartphone",
          controller: _searchController,
          lines: 1,
          onChanged: (value) {
            widget.bloc
                .add(SearchInitEvent(item: _searchController.text.trim()));
          },
          onEditingComplete: () {
            widget.bloc
                .add(SearchInitEvent(item: _searchController.text.trim()));
            // print("editing complete");
          },
          suffix: IconButton(
            onPressed: () {
              widget.bloc
                  .add(SearchInitEvent(item: _searchController.text.trim()));
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (widget.state.searching)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("searching..."),
                ),
              ),
            if (widget.state.shown == 0 &&
                widget.state.total == 0 &&
                !widget.state.searching &&
                _searchController.text.isNotEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("Result not Found!"),
                ),
              ),
            if (!widget.state.searching)
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (ProductModal product in widget.state.productList ?? [])
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
            //
          ],
        ),
      ),
    );
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
}
