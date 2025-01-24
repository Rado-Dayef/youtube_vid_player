import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_vid_player/constants/colors.dart';
import 'package:youtube_vid_player/constants/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    "fUIzY-svDuY",
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
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
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(
        () {
          _videoMetaData = _controller.metadata;
        },
      );
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) => Scaffold(
        body: ListView(
          children: [
            player,
            Padding(
              padding: 8.edgeInsetsAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _videoMetaData.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor),
                  ),
                  25.gap,
                  TextField(
                    enabled: _isPlayerReady,
                    controller: _idController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter a video URL",
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.blueAccent,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: AppColors.darkBlueColor,
                        ),
                        onPressed: () => _idController.clear(),
                      ),
                    ),
                  ),
                  10.gap,
                  InkWell(
                    onTap: _isPlayerReady
                        ? () {
                            if (_idController.text.isNotEmpty) {
                              var id = YoutubePlayer.convertUrlToId(
                                    _idController.text,
                                  ) ??
                                  '';
                              _controller.load(id);
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          }
                        : null,
                    child: Container(
                      padding: 10.edgeInsetsAll,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: 10.borderRadiusAll,
                      ),
                      child: Text(
                        "Get Vid",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  10.gap,
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _muted ? Icons.volume_off : Icons.volume_up,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: _isPlayerReady
                            ? () {
                                _muted ? _controller.unMute() : _controller.mute();
                                setState(() {
                                  _muted = !_muted;
                                });
                              }
                            : null,
                      ),
                      Expanded(
                        child: Slider(
                          activeColor: AppColors.whiteColor,
                          inactiveColor: Colors.transparent,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: '${(_volume).round()}',
                          onChanged: _isPlayerReady
                              ? (value) {
                                  setState(
                                    () {
                                      _volume = value;
                                    },
                                  );
                                  _controller.setVolume(_volume.round());
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
