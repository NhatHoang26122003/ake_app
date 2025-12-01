import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/base/widgets/app_button.dart';
import 'package:tekup_connection_mobile/common/base/widgets/app_text_field.dart';
import 'package:tekup_connection_mobile/common/base/widgets/base_page_widget.dart';
import 'package:tekup_connection_mobile/resource/asset/app_images.dart';
import 'package:tekup_connection_mobile/resource/theme/app_colors.dart';
import 'package:tekup_connection_mobile/resource/theme/app_style.dart';
import 'package:tekup_connection_mobile/ui/profile/controller/profile_controller.dart';
import 'package:tekup_connection_mobile/utils/app_validator.dart';

class ProfilePage extends BasePage<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          _buildProfileBar(context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    _buildCircleAvatar(),
                    SizedBox(height: 20.h),
                    _buildInfo(),
                    SizedBox(height: 20.h),
                    _buildButton(),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Text(
                          "changePassword".tr,
                          style: AppStyles.STYLE_14.copyWith(
                            color: AppColors.black80,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.black80,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileBar(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black80.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: statusBarHeight + 10.h, bottom: 10.h, left: 10.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: SvgPicture.asset(
                AppImages.icMenu,
                width: 24.h,
                height: 28.h,
                fit: BoxFit.scaleDown,
                colorFilter: const ColorFilter.mode(
                  AppColors.black80,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () => Get.back(),
            ),
            SizedBox(width: 10.w),
            Text(
              "profile".tr,
              style: AppStyles.STYLE_18.copyWith(
                color: AppColors.black80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return Container(
      width: 0.3.sw,
      height: 0.3.sw,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(60.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black80.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          controller.user.name[0].toUpperCase(),
          style: TextStyle(
            fontSize: 50.w,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppTextFiled(
          labelText: "email".tr,
          isRequired: false,
          isReadOnly: true,
          controller: controller.emailController,
        ),
        SizedBox(height: 10.h),
        AppTextFiled(
          labelText: "username".tr,
          hintText: "enterUsername".tr,
          isRequired: false,
          controller: controller.usernameController,
          validator: (value) => AppValidator.validUserName(value),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: AppButton(
            text: "cancel".tr,
            textStyle: AppStyles.STYLE_16.copyWith(
              color: AppColors.black80,
              fontWeight: FontWeight.w700,
            ),
            colorActive: Colors.grey[50],
            onPressed: Get.back,
          ),
        ),
        SizedBox(width: 20.w),
        Flexible(
          flex: 1,
          child: AppButton(
            text: "save".tr,
            textStyle: AppStyles.STYLE_16.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
            colorActive: AppColors.mainColor,
            onPressed: () => controller
                .updateUsername(controller.usernameController.text.trim()),
          ),
        ),
      ],
    );
  }
}
