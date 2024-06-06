import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/modal/product_modal.dart';
import 'package:pms/network/api_endpoint.dart';
import 'package:pms/network/api_service.dart';
import 'package:pms/utills/custom_toast.dart';
import 'package:pms/utills/date_formatt.dart';
import 'package:pms/widget/custom_button.dart';
import 'package:pms/widget/error_image_builder.dart';

class ProductScreen extends StatefulWidget {
  final ProductModal product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ScrollController _scrollController;

  bool leadGap = false;
  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        leadGap = true;
      } else {
        leadGap = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scrnWidth = MediaQuery.sizeOf(context).width;
    double cardWidth =
        scrnWidth > 612 ? (scrnWidth - 5 * 16) / 4 : (scrnWidth - 3 * 16) / 3;

    double discount = widget.product.discountPercentage ?? 0.0;
    double price = widget.product.price ?? 0.0;
    double discountedAmount = price - (discount / 100) * price;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            surfaceTintColor: AppColors.kwhiteColor,
            elevation: 5,
            backgroundColor: AppColors.kwhiteColor,
            stretch: true,
            pinned: true,
            expandedHeight: 230, // Set
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: false,
              expandedTitleScale: 1,
              titlePadding: const EdgeInsets.all(0),
              title: Container(
                padding: EdgeInsets.fromLTRB(
                    leadGap ? 52 : 16, leadGap ? 16 : 0, 16, leadGap ? 16 : 6),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 1.0, end: 0.0),
                  duration: const Duration(milliseconds: 500),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.scale(
                      scale: 1 + value, // Scale factor for the title
                      child: Opacity(
                        opacity: 1 - value, // Opacity factor for the title
                        child: Text(
                          widget.product.title ?? "",
                          style: CustomTextStyle.appBarTitleStyle
                              .copyWith(color: AppColors.kMatteBlack),
                        ),
                      ),
                    );
                  },
                ),
              ),
              background: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CarouselSlider.builder(
                      itemCount: (widget.product.images ?? []).length,
                      itemBuilder: (context, index, realIndex) =>
                          CachedNetworkImage(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: widget.product.thumbnail ?? "",
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) =>
                                buildErrorImage(),
                          ),
                      options:
                          CarouselOptions(height: 220, viewportFraction: 1)),
                ],
              ),
            ),
            leading: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.kwhiteColor.withOpacity(0.8),
                  foregroundColor: AppColors.kMatteBlack,
                ),
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
                  // color: AppColors.kRedColor,
                )),
            actions: [
              IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.kwhiteColor.withOpacity(0.8),
                  ),
                  onPressed: () {
                    context.push('/product/Edit', extra: widget.product);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.kMatteBlack,
                  )),
              IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.kwhiteColor.withOpacity(0.8),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        title: Text(
                          "Delete",
                          style: CustomTextStyle.appBarTitleStyle.copyWith(
                            fontSize: 20,
                            color: AppColors.kRedColor,
                          ),
                        ),
                        content: RichText(
                            text: TextSpan(
                                style: CustomTextStyle.descriptionStyle
                                    .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                text: 'Are you sure to delete product ',
                                children: [
                              TextSpan(
                                text: '"${widget.product.title ?? ""}"',
                                style: CustomTextStyle.descriptionStyle
                                    .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                              )
                            ])),
                        //  Text(
                        //     "Are you sure to delete product '${widget.product.title ?? ""}'?"),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: AppColors.kblueColor),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: AppColors.kRedColor),
                            onPressed: () {
                              Navigator.pop(context);
                              _delete(prooductID: widget.product.id);
                            },
                            child: Text('Delete'),
                          )
                        ],
                      ),
                    );

                    // _delete(prooductID: widget.product.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.kRedColor,
                  ))
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              // alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        itemSize: 24,
                        updateOnDrag: false,
                        // tapOnlyMode: false,
                        glow: false,

                        ignoreGestures: true,
                        unratedColor: AppColors.kLightGreyColor,
                        initialRating: widget.product.rating ?? 0.0,
                        allowHalfRating: true,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (value) {},
                      ),
                      Column(
                        children: [
                          Text(
                            '\$ ${discountedAmount.toStringAsFixed(2)}',
                            style: CustomTextStyle.cardPriceStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$ $price ',
                                style: CustomTextStyle.carddateStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(
                                ' -${widget.product.discountPercentage}%',
                                style: CustomTextStyle.carddateStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      // Text(widget.product.rating.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  RichText(
                    text: TextSpan(
                        style: CustomTextStyle.descriptionStyle.copyWith(
                          color: AppColors.kGreyColor,
                        ),
                        text: "Brand : ",
                        children: [
                          TextSpan(
                              text: widget.product.brand ?? "N/A",
                              style: CustomTextStyle.descriptionStyle),
                        ]),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  // customButton(
                  //   title: "Add to Cart",
                  //   icon: Icons.shopping_cart,
                  //   onPressed: () {},
                  // ),
                  //
                  SizedBox(
                    height: 24,
                  ),

                  Text(
                    widget.product.description ?? "",
                    style: CustomTextStyle.descriptionStyle,
                  ),
                ],
              ),
            ),
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reviews",
                    style: CustomTextStyle.homeFieldTitleStyle,
                  ),
                  for (Review review in widget.product.reviews ?? [])
                    _buildReviewCard(review: review)
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }

  Widget _buildReviewCard({required Review review}) {
    String name = review.reviewerName ?? "", shortName = "";
    List splitted = name.split(" ");
    for (String element in splitted) {
      if (element.isNotEmpty) {
        shortName = shortName + element[0];
      }
    }

    return Card(
        surfaceTintColor: AppColors.kwhiteColor,
        color: AppColors.kwhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kPrimaryColor,
                    ),
                    child: Text(
                      shortName,
                      style: CustomTextStyle.appBarTitleStyle,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  // CircleAvatar(
                  //   c
                  // ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              review.reviewerName ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.kMatteBlack,
                              ),
                            ),
                            Text(
                              getTimeAgo(review.date),
                              style: CustomTextStyle.carddateStyle,
                            ),
                          ],
                        ),
                        Text(
                          review.reviewerEmail ?? "",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.kMatteBlack,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        RatingBar.builder(
                          itemSize: 12,
                          updateOnDrag: false,
                          // tapOnlyMode: false,
                          glow: false,

                          ignoreGestures: true,
                          unratedColor: AppColors.kLightGreyColor,
                          initialRating:
                              double.parse("${review.rating ?? 0.0}"),
                          allowHalfRating: true,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                review.comment ?? "",
                style: CustomTextStyle.cardDescStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.kMatteBlack),
              ),
            ],
          ),
        ));
  }

  Future _delete({int? prooductID}) async {
    final APIService apiService = APIService();

    _showAlert();
    try {
      final res = await apiService
          .request(
              "${ApiEndPoint.kGetProducts}/$prooductID", METHOD.DELETE, null)
          .whenComplete(() {
        Navigator.pop(context);
      });
      if (res != null && res.data != null) {
        CustomToast.showMessage("Product Deleted successfully");
        Navigator.pop(context);
      } else {
        CustomToast.showMessage("Error Deleting Product");
      }
    } catch (e) {
      CustomToast.showMessage("Error Deleting Product", isError: true);
      // Navigator.pop(context);
    }
  }

  _showAlert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
          child: CircularProgressIndicator(
        color: AppColors.kwhiteColor,
      )),
    );
  }
}
