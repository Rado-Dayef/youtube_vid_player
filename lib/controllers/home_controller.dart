import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeController extends GetxController {
  bool muted = false;
  double volume = 100;
  bool isUrlEmpty = true;
  bool isPlayerReady = false;
  PlayerState playerState = PlayerState.unknown;
  YoutubeMetaData videoMetaData = const YoutubeMetaData();
  TextEditingController urlController = TextEditingController();
  TextEditingController seekToController = TextEditingController();
  YoutubePlayerController controller = YoutubePlayerController(initialVideoId: "", flags: const YoutubePlayerFlags(mute: false, loop: false, isLive: false, autoPlay: true, forceHD: false, hideThumbnail: true, enableCaption: false, disableDragSeek: false));
  final List<String> ids = ['nPt8bK2gbaU', 'gQDByCdjUXw', 'iLnmTe5Q2Qw', '_WoCV4c6XOE', 'KmzdUe0RSJo', '6jZDSSZZxjQ', 'p2lYr3vM_1w', '7QUtEmBT_-w', '34_PXCzGw1M'];

  @override
  void onInit() {
    controller = YoutubePlayerController(
      initialVideoId: "",
      flags: const YoutubePlayerFlags(
        mute: false,
        loop: false,
        isLive: false,
        autoPlay: true,
        forceHD: false,
        hideThumbnail: true,
        enableCaption: false,
        disableDragSeek: false,
      ),
    )..addListener(listener);
    super.onInit();
  }

  void listener() {
    if (isPlayerReady && !controller.value.isFullScreen) {
      playerState = controller.value.playerState;
      videoMetaData = controller.metadata;
    }
  }
}
