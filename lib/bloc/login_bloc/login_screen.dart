import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_const/app_text.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_router/app_router.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:pms/provider/app_provider.dart';
import 'package:pms/utills/custom_toast.dart';
import 'package:pms/utills/form_validator.dart';
import 'package:pms/widget/custom_button.dart';
import 'package:pms/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = 'mail@gmail.com';
      _passwordController.text = 'Password@123';
    }
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        bottom: false,
        // right: false,
        // left: false,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              CustomToast.showMessage(state.messgae, isError: true);
            }
            if (state is LoginSuccess) {
              CustomToast.showMessage(state.messgae,
                  bgcolor: AppColors.kwhiteColor);
              AppRouter().clearAndNavigate(path: '/home');
              Provider.of<AppProvider>(context, listen: false).init();

              // context.go('/mainHome');
            }
            // if (state is LoginNotApproved) {
            //   context.pushReplacement('/notApproved');
            //   CustomToast.showMessage(state.messgae, isError: true);
            // }
          },
          builder: (context, state) {
            final bloc = context.read<LoginBloc>();
            switch (state) {
              case LoginInitial():
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.2,
                        ),
                        // Center(
                        //   child: Container(
                        //     decoration: const BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       // color: AppColors.kwhiteColor,
                        //     ),
                        //     child: Image.asset(
                        //       AppImgs.kAppLogo,
                        //       width: 120,
                        //       // color: AppColors.kwhiteColor,
                        //     ),
                        //   ),
                        // ),
                        //
                        Center(
                          child: Text(
                            kAppName,
                            style: CustomTextStyle.splashTitleStyle,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Card(
                          surfaceTintColor: Colors.white,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Login",
                                    style: CustomTextStyle.appBarTitleStyle
                                        .copyWith(
                                      color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Login into your account.",
                                    style:
                                        CustomTextStyle.cardDescStyle.copyWith(
                                      fontSize: 15,

                                      // color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomTextField(
                                    title: 'Email',
                                    showTitle: true,
                                    hintText: 'example@gmail.com',
                                    prefixIcon: Icon(
                                      Icons.phone_outlined,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                    keyboardTyp: TextInputType.emailAddress,
                                    validator: (value) =>
                                        Validator.validateEmail(email: value!),
                                    controller: _emailController),
                                CustomTextField(
                                  title: 'Password',
                                  hintText: 'xxxxxxx',
                                  showTitle: true,
                                  keyboardTyp: TextInputType.visiblePassword,
                                  prefixIcon: Icon(
                                    // CupertinoIcons.mail,
                                    CupertinoIcons.padlock,
                                    // Icons.mail_outline_rounded,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                  controller: _passwordController,
                                  isObscure: true,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                          password: value!),
                                ),
                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child: InkWell(
                                //     borderRadius: BorderRadius.circular(8),
                                //     onTap: () {},
                                //     child: Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 12, vertical: 6),
                                //       child: Text(
                                //         'Forgot Password?',
                                //         style: TextStyle(
                                //           color: AppColors.kMatteBlack,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 28,
                                ),
                                customButton(
                                  isLoading: state.loading,
                                  title: 'Login',
                                  icon: Icons.login_rounded,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bloc.add(LoginSubmmitEvent(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ));
                                    }

                                    // AppRouter()
                                    //     .clearAndNavigate(path: '/mainHome');
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          color: AppColors.kMatteBlack,
                                          fontSize: 15,
                                          height: 1.5,
                                        ),
                                        text: "Don't have an account? ",
                                        children: [
                                          TextSpan(
                                            text: 'Register',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.pushNamed(
                                                    AppRouteName.register);
                                              },
                                            style: TextStyle(
                                              color: AppColors.kPrimaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // Text("data"),
                      ],
                    ),
                  ),
                );

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
