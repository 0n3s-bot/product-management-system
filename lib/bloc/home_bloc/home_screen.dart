import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:pms/modal/category_modal.dart';
import 'package:pms/utills/custom_toast.dart';
import 'package:pms/widget/custom_textfield.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator.adaptive(
                      onRefresh: () async {
                        bloc.add(HomeInitEvent());
                      },
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        children: [
                          Container(),
                          CustomTextField(
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
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              for (CategoryModal category
                                  in state.categoryList ?? [])
                                Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    child: Text(
                                      category.name ?? "",
                                      style: CustomTextStyle.categoryTitleStyle,
                                    )),
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
