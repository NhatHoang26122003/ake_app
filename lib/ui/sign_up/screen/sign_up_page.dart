import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/base/widgets/app_button.dart';
import 'package:tekup_connection_mobile/common/base/widgets/app_text_field.dart';
import 'package:tekup_connection_mobile/common/base/widgets/base_page_widget.dart';
import 'package:tekup_connection_mobile/resource/asset/app_images.dart';
import 'package:tekup_connection_mobile/resource/theme/app_colors.dart';
import 'package:tekup_connection_mobile/resource/theme/app_style.dart';
import 'package:tekup_connection_mobile/ui/sign_up/controller/sign_up_controller.dart';
import 'package:tekup_connection_mobile/utils/app_validator.dart';

class SignUpPage extends BasePage<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Text(
              "appName".tr,
              style: AppStyles.STYLE_28_BOLD.copyWith(
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 80.h),
            Container(
              width: double.infinity,
              height: 0.75.sh,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.05),
                    offset: const Offset(0.3, 0.3),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "signUp".tr,
                      style: AppStyles.STYLE_24_BOLD.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "subTitle".tr,
                      style: AppStyles.STYLE_12.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    _buildInputSection(),
                    SizedBox(height: 40.h),
                    AppButton(
                      text: "signUp".tr,
                      onPressed: controller.onSignUp,
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "hasAccount".tr,
                            style: AppStyles.STYLE_14.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          TextSpan(
                            text: " ${"login".tr}",
                            style: AppStyles.STYLE_14.copyWith(
                              color: AppColors.colorFF7E5F,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.onNavigateLoginPage,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextFiled(
            labelText: "userName".tr,
            hintText: "enterUserName".tr,
            controller: controller.userNameController,
            validator: (value) => AppValidator.validUserName(value),
          ),
          SizedBox(height: 10.h),
          AppTextFiled(
            labelText: "email".tr,
            hintText: "enterEmail".tr,
            controller: controller.emailController,
            validator: (value) => AppValidator.validateEmail(value),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => AppTextFiled(
              labelText: "password".tr,
              hintText: "enterPassword".tr,
              controller: controller.passwordController,
              obscureText: !controller.isShowPassword.value,
              validator: (value) => AppValidator.validatePassword(value),
              suffixIcon: InkWell(
                onTap: controller.toggleShowPassword,
                child: SvgPicture.asset(
                  controller.isShowPassword.value
                      ? AppImages.icEyeSlash
                      : AppImages.icEye,
                  height: 24.w,
                  width: 24.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => AppTextFiled(
              labelText: "confirmPassword".tr,
              hintText: "enterConfirmPassword".tr,
              controller: controller.confirmPasswordController,
              obscureText: !controller.isShowConfirmPassword.value,
              validator: (value) => AppValidator.validateConfirmPassword(
                value,
                controller.passwordController.text.trim(),
              ),
              suffixIcon: InkWell(
                onTap: controller.toggleShowConfirmPassword,
                child: SvgPicture.asset(
                  controller.isShowConfirmPassword.value
                      ? AppImages.icEyeSlash
                      : AppImages.icEye,
                  height: 24.w,
                  width: 24.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
