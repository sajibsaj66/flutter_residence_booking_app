import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key,
    required this.title,
    required this.hintText,
    this.prefixSvgIcon,
    this.isPassword = false,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.validator});


final String title;
final String hintText;
final String? prefixSvgIcon;
final TextEditingController controller;
final bool isPassword;
final TextInputAction textInputAction;
final FormFieldValidator? validator;
final TextInputType keyboardType;


@override
State<CustomTextField> createState() => _CustomTextFieldState();}

class _CustomTextFieldState extends State<CustomTextField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title.isEmpty ? " " : widget.title,
            style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackPrimary),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.isPassword ? obscureText : false,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD7263D)),
            ),
            hintText: widget.hintText == '' ? " " : widget.hintText,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                onTap: toggle,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 16, top: 20, bottom: 20, end: 12),
                  child: obscureText
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                ))
                : null,
          ),
        ),
      ],
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
