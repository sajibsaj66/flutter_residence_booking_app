import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/widgets/text/custom_text.dart';

class CustomField extends StatelessWidget {
   const CustomField(
      {super.key,
        this.maxLines = 1,
        this.text = "",
        this.isLabel = true,
        this.hintText = "",
        this.fontSize = 14,
        this.bottom = 8,
        this.top = 16,
        this.borderRadius = 8,
        this.borderWidth = 0.50,
        this.borderSideColor = AppColors.black10,
        this.fontWeight = FontWeight.w400,
        this.hintTextColor = AppColors.black60,
        this.height = 52,
        this.width = double.maxFinite,
        this.backgroundColor = Colors.white,
        this.paddingLeft = 16,
        this.paddingRight = 16,
        this.paddingTop = 16,
        this.paddingBottom = 16,
        this.alignment = Alignment.center,
        this.contentPaddingLeft = 0,
        this.contentPaddingRight = 0,
        this.contentPaddingTop = 10,
        this.contentPaddingBottom = 10,
        this.controller,
        this.validator,
        this.readOnly = false});

  final double height;
  final double width;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final double fontSize;
  final double bottom;
  final double top;
  final double borderRadius;
  final double borderWidth;
  final Color borderSideColor;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final Color hintTextColor;
  final String text;
  final String hintText;
  final Alignment alignment;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final double contentPaddingTop;
  final double contentPaddingBottom;
  final bool isLabel;
  final bool readOnly;
  final FormFieldValidator? validator;
  final int maxLines;


  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLabel
            ? CustomText(
          text: text,
          bottom: bottom,
          top: top,
        )
            : const SizedBox(),
        const SizedBox(height: 8),
        Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(
              left: paddingLeft,
              right: paddingRight,
              top: paddingTop,
              bottom: paddingBottom),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderSideColor, width: borderWidth),
          ),
          child: Align(
            alignment: alignment,
            child: TextFormField(validator: validator,
              readOnly: readOnly,
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    top: contentPaddingTop,
                    bottom: contentPaddingBottom,
                    left: contentPaddingLeft,
                    right: contentPaddingRight),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: GoogleFonts.raleway(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: hintTextColor
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
