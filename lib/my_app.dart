import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_vid_player/constants/bindings.dart';
import 'package:youtube_vid_player/constants/pages.dart';
import 'package:youtube_vid_player/constants/strings.dart';
import 'package:youtube_vid_player/constants/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: AppThemes.themeData,
      getPages: AppPages.getPages,
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppStrings.homeRoute,
    );
  }
}
