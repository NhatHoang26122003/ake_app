import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tekup_connection_mobile/common/base/widgets/app_text_field.dart';
import 'package:tekup_connection_mobile/common/base/widgets/chat_message_bubble.dart';
import 'package:tekup_connection_mobile/resource/asset/app_images.dart';
import 'package:tekup_connection_mobile/resource/theme/app_colors.dart';
import 'package:tekup_connection_mobile/resource/theme/app_style.dart';
import 'package:tekup_connection_mobile/ui/main/controller/main_controller.dart';

import '../../../common/base/widgets/base_page_widget.dart';

class MainPage extends BasePage<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColors.white,
      drawer: _buildDrawer(),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: _buildChatList(),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                "newChat".tr,
                style: AppStyles.STYLE_18.copyWith(color: AppColors.black80),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  InkWell(
                    onTap: () =>
                        controller.scaffoldKey.currentState?.openDrawer(),
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
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    "appName".tr,
                    style: AppStyles.STYLE_18.copyWith(
                      color: AppColors.black80,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: controller.onProfileTapped,
                child: SvgPicture.asset(
                  AppImages.icProfile,
                  width: 24.h,
                  height: 24.h,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black80,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      width: 0.6.sw,
      backgroundColor: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: ListTile(
                  // contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    AppImages.icNewChat,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.scaleDown,
                  ),
                  title: Text(
                    "newChat".tr,
                    style: AppStyles.STYLE_18.copyWith(
                      color: AppColors.black80,
                    ),
                  ),
                  onTap: controller.onNewChat,
                ),
              ),
            ),
            SizedBox(height:25.h),
            Text(
              "historyChat".tr,
              style: AppStyles.STYLE_18.copyWith(
                color: AppColors.black80,
                fontWeight: FontWeight.w700,
              ),
            ),
            Obx(() {
              return Column(
                children: controller.chatHistory
                    .map((historyItem) => ListTile(
                          title: Text(historyItem.name ?? "newChat".tr),
                          onTap: () => controller.loadMessages(historyItem.id ?? 0),
                        ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return Obx(
      () => ListView.builder(
        reverse: true,
        padding: EdgeInsets.all(16.w),
        itemCount: controller.messageList.length,
        itemBuilder: (context, index) {
          final message = controller.messageList[index];
          return ChatMessageBubble(
            text: message.text,
            role: message.role,
          );
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: AppColors.white,
      child: Row(
        children: [
          Expanded(
            child: AppTextFiled(
              controller: controller.textController,
              hintText: "Enter question".tr,
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: controller.sendMessage,
            child: SvgPicture.asset(
              AppImages.icSend,
              width: 24.h,
              height: 24.h,
              fit: BoxFit.scaleDown,
              colorFilter: const ColorFilter.mode(
                AppColors.mainColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
