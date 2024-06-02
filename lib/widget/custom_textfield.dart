import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final double? bottomgap, upperGAp;
  final int? lines, maxLength;
  final double radiusBorder;
  final bool? isEnabled, border, isRequired, isObscure;
  final bool autofocus, showTitle;
  final Widget? suffix, prefixIcon;
  final void Function()? onTap;
  final TextInputType? keyboardTyp;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final void Function(String?)? onSaved, onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final void Function()? onEditingComplete;
  final String? title, hintText;

  const CustomTextField(
      {super.key,
      required this.controller,
      this.bottomgap,
      this.upperGAp,
      this.lines,
      this.radiusBorder = 8,
      this.isEnabled,
      this.border,
      this.isRequired,
      this.showTitle = false,
      this.suffix,
      this.prefixIcon,
      this.onTap,
      this.keyboardTyp,
      this.isObscure,
      this.autofocus = false,
      this.maxLength,
      this.style,
      this.inputFormatters,
      this.floatingLabelBehavior,
      this.onSaved,
      this.onChanged,
      this.onTapOutside,
      this.validator,
      this.contentPadding,
      this.fillColor,
      this.onEditingComplete,
      this.title,
      this.hintText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _userFocusnode = FocusNode();

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.bottomgap ?? 6, top: widget.upperGAp ?? 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: widget.showTitle,
              child: requiredTitleWidget(
                  style: widget.style,
                  title: "${widget.title}",
                  isrequired: widget.isRequired ?? false)),
          // if (widget.showTitle == true)
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            cursorColor: AppColors.kPrimaryColor,
            autofocus: widget.autofocus,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.kMatteBlack,
            ),
            maxLength: widget.maxLength,
            maxLines: (widget.isObscure ?? false) ? 1 : widget.lines,
            readOnly: widget.isEnabled == false ? true : false,
            keyboardType: widget.keyboardTyp,
            obscureText: widget.isObscure == true ? _visible : false,
            controller: widget.controller,
            focusNode: _userFocusnode,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            onEditingComplete: widget.onEditingComplete,
            onTap: widget.onTap,
            onSaved: widget.onSaved,
            onTapOutside: widget.onTapOutside ??
                (event) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
            onChanged: widget.onChanged,
            decoration: InputDecoration(
                alignLabelWithHint: true,
                labelStyle: const TextStyle(
                  fontSize: 15,
                ),
                label: widget.showTitle == true
                    ? null
                    : widget.title != null
                        ? requiredTitleWidget(
                            style: widget.style,
                            isSemicolon: false,
                            title: "${widget.title}",
                            isrequired: widget.isRequired ?? false)
                        : null,
                errorStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.kRedColor,
                  fontWeight: FontWeight.w400,
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: widget.floatingLabelBehavior,
                isDense: true,
                fillColor: widget.fillColor,
                filled: widget.fillColor != null,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.isObscure == true
                    ? IconButton(
                        onPressed: () {
                          _visible = !_visible;
                          setState(() {});
                        },
                        icon: Icon(
                          _visible
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.kPrimaryColor,
                        ),
                      )
                    : widget.suffix,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder),
                  borderSide: BorderSide(
                    color: AppColors.kPrimaryColor,
                    width: 0.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder),
                  borderSide: BorderSide(
                    color: AppColors.kRedColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder),
                  borderSide: BorderSide(
                    color: AppColors.kGreyColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder),
                  borderSide: BorderSide(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radiusBorder),
                  borderSide: BorderSide(
                    color: AppColors.kPrimaryColor,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

Widget requiredTitleWidget(
    {required String title,
    bool isrequired = true,
    bool isSemicolon = true,
    TextStyle? style}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text("$title ", style: style ?? CustomTextStyle.textfieldTitleStyle),
      if (isrequired)
        Text('*',
            style: (style ??
                CustomTextStyle.textfieldTitleStyle.copyWith(
                  color: AppColors.kRedColor,
                ))),
      if (isSemicolon) Text(' :', style: CustomTextStyle.textfieldTitleStyle),
    ],
  );
}
