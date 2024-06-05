import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_cache/shared_pref/shared_pref.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_router/app_router.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/modal/register_modal.dart';
import 'package:pms/provider/app_provider.dart';
import 'package:provider/provider.dart';

class Customdrawer extends Drawer {
  const Customdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double scrnHeight = MediaQuery.of(context).size.height;
    double scrnWidth = MediaQuery.of(context).size.width;

    double resHeight =
        MediaQuery.orientationOf(context).index == 1 ? scrnWidth : scrnHeight;
    double resWidth =
        MediaQuery.orientationOf(context).index == 0 ? scrnWidth : scrnHeight;
    //
    bool islogged = Provider.of<AppProvider>(context, listen: false).loggedIn;

    RegisterModal user = Provider.of<AppProvider>(context, listen: false).user;

    List splitted = (user.name ?? "").split(' ');

    String shortname = "";

    for (var element in splitted) {
      shortname = shortname + element[0];
    }

    return Drawer(
      child: SingleChildScrollView(
        child: SizedBox(
          height: resHeight,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      left: false,
                      right: false,
                      child: islogged
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                    padding: const EdgeInsets.all(14),
                                    child: Text(
                                      shortname.toUpperCase(),
                                      style: CustomTextStyle.splashTitleStyle,
                                    ),
                                  ),
                                  // ClipRRect(

                                  //   borderRadius: BorderRadius.circular(
                                  //     resWidth * 0.2,
                                  //   ),
                                  //   child:
                                  //    CachedNetworkImage(
                                  //       height: resWidth * 0.2,
                                  //       width: resWidth * 0.2,
                                  //       imageUrl:
                                  //           "https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1769"),
                                  // ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    user.name ?? "",
                                    // "Jhon Doe",
                                    style: CustomTextStyle.cardTitleStyle,
                                  ),
                                  Text(
                                    user.email ?? "",
                                    style: CustomTextStyle.cardSubTitleStyle,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 20,
                            ),
                    ),
                    // const Text("Drawer"),
                    const SizedBox(
                      height: 4,
                    ),
                    // _buildSelector(
                    //     title: "Category", icon: Icons.category_outlined),

                    // _buildSelector(
                    //     title: "Notification",
                    //     icon: Icons.notifications_outlined),

                    _buildSelector(
                      title: "Add Product",
                      icon: Icons.add,
                      onTap: () {
                        context.pop();
                        context.pushNamed(AppRouteName.addProduct);
                      },
                    ),

                    _buildSelector(
                      title: "Search",
                      icon: Icons.search,
                      onTap: () {
                        context.pop();
                        context.push('/search');
                      },
                    ),

                    if (islogged)
                      _buildSelector(
                        title: "Logout",
                        icon: Icons.exit_to_app_rounded,
                        onTap: () {
                          CustomSharedPreference.signOut();
                          context.pushNamed(AppRouteName.login);
                        },
                      ),

                    if (!islogged)
                      _buildSelector(
                        title: "Login",
                        icon: Icons.exit_to_app_rounded,
                        onTap: () {
                          // CustomSharedPreference.signOut();
                          context.pushNamed(AppRouteName.login);
                        },
                      ),

                    const Divider(),
                  ],
                ),
              ),
              // Text("Beco                                                                                                                                 me a Seller")

              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildSelector(
      {IconData? icon, required String title, void Function()? onTap}) {
    return Column(
      children: [
        const Divider(),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 48,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.kMatteBlack,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kMatteBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
