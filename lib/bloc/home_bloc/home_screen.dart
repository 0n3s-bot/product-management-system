import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_router/app_router.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/bloc/drawer/custom_drawer.dart';
import 'package:pms/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:pms/modal/category_modal.dart';
import 'package:pms/modal/product_modal.dart';
import 'package:pms/utills/custom_toast.dart';
import 'package:pms/widget/custom_textfield.dart';
import 'package:pms/widget/error_image_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    //
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screnWidth = MediaQuery.sizeOf(context).width;
    double boxwidth = MediaQuery.orientationOf(context).index == 0
        ? (screnWidth - 3 * 16) / 2
        : (screnWidth - 5 * 16) / 4;

    _scrollController.addListener(() {
      var nextPageTrigger = 0.9999 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger) {
        BlocProvider.of<HomeBloc>(context).add(HomeLoadMoreEvent(page: 2));
      }
    });

    return Scaffold(
      drawer: Customdrawer(),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            CustomToast.showMessage("error Occured", isError: true);
          }
        },
        builder: (context, state) {
          final bloc = context.read<HomeBloc>();
          switch (state) {
            case HomeInitial():
              return state.loading && state.categoryList == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator.adaptive(
                      onRefresh: () async {
                        bloc.add(HomeInitEvent());
                      },
                      child: ListView(
                        controller: _scrollController,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        children: [
                          // Container(),
                          if (state.loading)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          CustomTextField(
                            isEnabled: false,
                            onTap: () {
                              context.pushNamed(AppRouteName.search);
                            },
                            controller: TextEditingController(),
                            hintText: "eg:smartphone",
                            prefixIcon: Icon(Icons.search),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Categories",
                            style: CustomTextStyle.homeFieldTitleStyle,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              for (CategoryModal category
                                  in state.categoryList ?? [])
                                // Text(category.toJson().toString()),
                                InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    context.pushNamed(AppRouteName.category,
                                        extra: category.toJson());
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 6),
                                      child: Text(
                                        category.name ?? "",
                                        style:
                                            CustomTextStyle.categoryTitleStyle,
                                      )),
                                ),
                              InkWell(
                                overlayColor: const WidgetStatePropertyAll(
                                    Colors.transparent),
                                onTap: () {
                                  bloc.add(HomeTriggerShowEvent());
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      // color: AppColors.kPrimaryColor,
                                      border: Border.all(
                                        width: 1.5,
                                        color: AppColors.kPrimaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    child: Text(
                                      state.showCategory ? "Hide" : "Show All",
                                      style: CustomTextStyle.categoryTitleStyle
                                          .copyWith(
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "All Products",
                            style: CustomTextStyle.homeFieldTitleStyle,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          // Text("${state.productList}"),
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              for (ProductModal product
                                  in state.productList ?? [])
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(child: Text("Loading...")),
                          )
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
              CachedNetworkImage(
                imageUrl: product.thumbnail ?? "",
                errorWidget: (context, url, error) => buildErrorImage(),
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
