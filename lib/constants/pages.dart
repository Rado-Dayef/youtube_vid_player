import 'package:get/get.dart';
import 'package:youtube_vid_player/constants/strings.dart';
import 'package:youtube_vid_player/views/screens/home_screen.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(
      name: AppStrings.homeRoute,
      page: () => const HomeScreen(),
      transition: Transition.noTransition,
    ),
  ];
}
