import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:tekup_connection_mobile/resource/theme/app_colors.dart";
import "package:tekup_connection_mobile/resource/theme/app_style.dart";

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    this.text,
    this.colorActive,
    this.colorText,
    this.textStyle,
  });
  final VoidCallback? onPressed;
  final String? text;
  final Color? colorActive;
  final Color? colorText;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: colorActive ?? AppColors.mainColor,
          backgroundColor: colorActive ?? AppColors.mainColor,
          foregroundColor: colorText ?? AppColors.white,
          elevation: 2.0,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            (text ?? "login".tr),
            style: textStyle ?? AppStyles.STYLE_20_BOLD.copyWith(
              color: colorText ?? AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
