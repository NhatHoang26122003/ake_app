import 'package:flutter/material.dart';
import 'package:tekup_connection_mobile/resource/theme/app_colors.dart';
import 'package:tekup_connection_mobile/resource/theme/app_style.dart';
import 'package:tekup_connection_mobile/ui/main/controller/main_controller.dart';

import '../../../common/base/widgets/base_page_widget.dart';

class MainPage extends BasePage<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.greenAccent,
      ),
      child: Center(
        child: Text(
          "Chat box",
          style: AppStyles.STYLE_24_BOLD.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
