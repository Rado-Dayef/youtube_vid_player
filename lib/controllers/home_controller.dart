import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_vid_player/constants/extensions.dart';
import 'package:youtube_vid_player/constants/strings.dart';

class HomeController extends GetxController {
  var isNoVid = true;
  var isYoutubeControllerInitialized = false.obs; // Reactive flag
  late YoutubePlayerController youtubeController;
  TextEditingController vidURLController = TextEditingController();

  @override
  void onClose() {
    if (isYoutubeControllerInitialized.value) {
      youtubeController.pause();
      youtubeController.dispose();
    }
    super.onClose();
  }

  void getVid() {
    if (vidURLController.text.isNotEmpty) {
      String? videoId = YoutubePlayer.convertUrlToId(vidURLController.text);

      if (videoId == null) {
        return;
      }

      if (!isYoutubeControllerInitialized.value) {
        youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            loop: false,
            mute: false,
            autoPlay: false,
            enableCaption: false,
          ),
        );
        isYoutubeControllerInitialized.value = true;
      } else {
        youtubeController.load(videoId);
      }
      isNoVid = false;
      update();
    } else {
      AppStrings.noVidURLToast.showToast;
    }
  }
}
