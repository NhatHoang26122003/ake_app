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
  });
  final VoidCallback? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.mainColor,
          backgroundColor: AppColors.mainColor,
          foregroundColor: AppColors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            (text ?? "login".tr),
            style: AppStyles.STYLE_20_BOLD.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
