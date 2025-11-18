import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tekup_connection_mobile/resource/theme/app_colors.dart';
import 'package:tekup_connection_mobile/resource/theme/app_style.dart';

class ChatMessageBubble extends StatelessWidget {
  final String text;
  final String role;

  const ChatMessageBubble({super.key, required this.text, required this.role});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (role == 'user') ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: (role == 'user') ? AppColors.mainColor : Colors.grey,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          text,
          style: AppStyles.STYLE_14.copyWith(
            color: (role == 'user') ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
