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
import '../../../data/model/chat_model.dart';

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
            child: Obx(() {
              if (controller.messageList.isEmpty &&
                  controller.currentChatId.value == null) {
                return _buildWelcomeScreen();
              }
              return _buildChatList();
            }),
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
        child: Row(
          children: [
            InkWell(
              onTap: () => controller.scaffoldKey.currentState?.openDrawer(),
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
            Expanded(
              child: Text(
                "appName".tr,
                style: AppStyles.STYLE_18.copyWith(
                  color: AppColors.black80,
                ),
              ),
            ),
            InkWell(
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
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "historyChat".tr,
                style: AppStyles.STYLE_18.copyWith(
                  color: AppColors.black80,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.chatHistories
                    .map((historyItem) => _buildChatHistory(historyItem))
                    .toList(),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildChatHistory(ChatModel historyItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            controller.loadMessages(historyItem.id);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: controller.checkCurrentChat(historyItem.id)
                  ? Colors.grey[100]
                  : AppColors.transparent,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      historyItem.title ?? "test".tr,
                      style: AppStyles.STYLE_18.copyWith(
                        color: AppColors.black80,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 8.w),
                  PopupMenuButton<_HistoryAction>(
                    color: AppColors.white,
                    shadowColor: Colors.grey,
                    icon: Icon(
                      Icons.more_horiz,
                      color: AppColors.black80,
                      size: 20.w,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: _HistoryAction.rename,
                        child: Text(
                          "rename".tr,
                          style: AppStyles.STYLE_18.copyWith(
                            color: AppColors.black80,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: _HistoryAction.delete,
                        child: Text(
                          "delete".tr,
                          style: AppStyles.STYLE_18.copyWith(
                            color: AppColors.black80,
                          ),
                        ),
                      ),
                    ],
                    onSelected: (action) {
                      if (action == _HistoryAction.rename) {
                        _showRenameDialog(historyItem);
                      }
                      if (action == _HistoryAction.delete) {
                        _showDeleteConfirm(historyItem);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${'welcome'.tr} ${controller.user.value?.name ?? ""}",
                    style: AppStyles.STYLE_20.copyWith(
                      color: AppColors.black80,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'suggestQuestion'.tr,
                    style: AppStyles.STYLE_20.copyWith(
                      color: AppColors.black80,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return Obx(
      () => ListView.builder(
        controller: controller.scrollController,
        reverse: false,
        padding: EdgeInsets.all(16.w),
        itemCount: controller.messageList.length +
            (controller.isLoadingResponse.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.messageList.length) {
            return Padding(
              padding: EdgeInsets.all(8.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                  ),
                ),
              ),
            );
          }
          final message = controller.messageList[index];
          return ChatMessageBubble(
            text: message.content,
            role: message.role,
          );
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: AppColors.transparent,
      child: Row(
        children: [
          Expanded(
            child: AppTextFiled(
              controller: controller.textController,
              hintText: "enterQuestion".tr,
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

  void _showRenameDialog(ChatModel item) {
    final newTitleController = TextEditingController(text: item.title);
    Get.dialog(
      AlertDialog(
        title: Text('rename'.tr),
        content: TextField(
          controller: newTitleController,
          autofocus: true,
          decoration: InputDecoration(hintText: 'enterTitle'.tr),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              final newTitle = newTitleController.text.trim();
              if (newTitle.isNotEmpty) {
                controller.renameChat(item.id!, newTitle);
              } else {
                showSimpleErrorSnackBar(message: 'titleNotEmpty'.tr);
              }
            },
            child: Text('save'.tr),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(ChatModel item) {
    Get.dialog(
      AlertDialog(
        title: Text('deleteChat'.tr),
        content: Text('confirmDelete'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              controller.deleteChat(item.id!);
            },
            child: Text('delete'.tr),
          ),
        ],
      ),
    );
  }
}

enum _HistoryAction { rename, delete }
