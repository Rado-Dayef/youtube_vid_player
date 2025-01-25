import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_vid_player/constants/colors.dart';
import 'package:youtube_vid_player/constants/extensions.dart';
import 'package:youtube_vid_player/constants/strings.dart';
import 'package:youtube_vid_player/controllers/home_controller.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.whiteColor,
            ),
      ),
      body: Center(
        child: GetBuilder<HomeController>(
          builder: (_) {
            return Obx(
              () {
                return ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    // Show player only if controller is initialized
                    controller.isYoutubeControllerInitialized.value
                        ? YoutubePlayerBuilder(
                            player: YoutubePlayer(
                              controller: controller.youtubeController,
                            ),
                            builder: (context, player) => player,
                          )
                        : const SizedBox.shrink(), // Empty container when not initialized
                    15.gap,
                    TextField(
                      controller: controller.vidURLController,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.whiteColor,
                          ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: 10.borderRadiusAll,
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: 10.borderRadiusAll,
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: 10.borderRadiusAll,
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: 10.borderRadiusAll,
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        hintText: AppStrings.vidURLText,
                        fillColor: Colors.blueAccent.withAlpha(20),
                        filled: true,
                        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.whiteColor.withAlpha(75),
                            ),
                        suffixIcon: InkWell(
                          onTap: () => controller.vidURLController.clear(),
                          child: const Icon(
                            Icons.clear,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    15.gap,
                    InkWell(
                      onTap: controller.getVid,
                      child: Container(
                        alignment: Alignment.center,
                        padding: 10.edgeInsetsAll,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: 10.borderRadiusAll,
                        ),
                        child: Text(
                          AppStrings.loadVidText,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
