import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_const/app_text.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/bloc/register_bloc/bloc/register_bloc.dart';
import 'package:pms/utills/custom_toast.dart';
import 'package:pms/utills/form_validator.dart';
import 'package:pms/widget/custom_button.dart';
import 'package:pms/widget/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrnHeight = MediaQuery.of(context).size.height;
    double scrnWidth = MediaQuery.of(context).size.width;

    double resHeight =
        MediaQuery.orientationOf(context).index == 1 ? scrnWidth : scrnHeight;
    // double resWidth =
    //     MediaQuery.orientationOf(context).index == 0 ? scrnWidth : scrnHeight;

    return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterError) {
              CustomToast.showMessage(state.message, isError: true);
            }
            if (state is RegisterSuccess) {
              context.pop();
              CustomToast.showMessage(state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: resHeight * 0.2,
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     AppImages.kAppLogo,
                  //     width: MediaQuery.of(context).size.width * 0.5,
                  //   ),
                  Text(kAppName, style: CustomTextStyle.splashTitleStyle
                      // .copyWith(color: AppColors.kMatteBlack),
                      ),

                  SizedBox(
                    height: resHeight * 0.05,
                  ),
                  Form(
                    key: _formKey,
                    child: Card(
                      // color: AppColors.kLightGreyColor,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Signup",
                              style: CustomTextStyle.loginTitleStyle,
                            ),
                            const Text(
                              "Create your Account.",
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomTextField(
                              controller: _nameController,
                              title: "Full Name",
                              showTitle: true,
                              lines: 1,
                              hintText: "Jhon Doe",
                              validator: (value) => Validator.validateField(
                                value: value!,
                                fieldName: "Full Name",
                              ),
                            ),

                            CustomTextField(
                              controller: _emailController,
                              title: "Email",
                              showTitle: true,
                              lines: 1,
                              hintText: "eg@mail.com",
                              keyboardTyp: TextInputType.emailAddress,
                              validator: (value) =>
                                  Validator.validateEmail(email: value!),
                            ),

                            CustomTextField(
                              controller: _addressController,
                              title: "Address",
                              showTitle: true,
                              lines: 1,
                              hintText: "street, city, province",
                              keyboardTyp: TextInputType.streetAddress,
                              validator: (value) => Validator.validateField(
                                  value: value!, fieldName: 'Address'),
                            ),

                            //
                            CustomTextField(
                              controller: _passwordController,
                              title: "Password",
                              showTitle: true,
                              isObscure: true,
                              hintText: "********",
                              keyboardTyp: TextInputType.visiblePassword,
                              validator: (value) =>
                                  Validator.validatePassword(password: value!),
                            ),
                            CustomTextField(
                                controller: _confirmPasswordController,
                                title: "Confirm Password",
                                showTitle: true,
                                isObscure: true,
                                hintText: "********",
                                keyboardTyp: TextInputType.visiblePassword,
                                validator: (value) => Validator.confirmPassword(
                                    password: value!,
                                    confirmpassword:
                                        _passwordController.text.trim())),

                            const SizedBox(
                              height: 16,
                            ),

                            //
                            customButton(
                              // icon: Icons.sign,
                              title: 'Sign up',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<RegisterBloc>().add(
                                      RegisterSubmitEvent(
                                          name: _nameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          address:
                                              _addressController.text.trim(),
                                          password: _confirmPasswordController
                                              .text
                                              .trim()));

                                  // print("object");
                                }
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: CustomTextStyle.cardbuttonTitleStyle,
                                  text: "Allready have an account? ",
                                  children: [
                                    TextSpan(
                                        text: 'Sign In',
                                        style: CustomTextStyle
                                            .cardbuttonTitleStyle
                                            .copyWith(
                                                color: AppColors.kblueColor,
                                                fontSize: 15),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.pop();
                                            // context.pushNamed(AppRouteName.register);
                                          }),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: resHeight * 0.16,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
