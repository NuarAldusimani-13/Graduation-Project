import 'package:flutter/material.dart';
import 'package:lip_reader/pages/boarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../providers/main_provider.dart';
import '../widgets/video_player_contr.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen(this.controller, {super.key});
  final VideoPlayerController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white.withOpacity(.9),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              VideoPlayerContr(controller),
              Positioned(
                bottom: MediaQuery.sizeOf(context).height * .15,
                child: Selector<MainProvider, String?>(
                    selector: (_, prov) => prov.videoText,
                    builder: (ctx, videoText, _) {
                      if (videoText == null) return const SizedBox();
                      return Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.sizeOf(context).width,
                        color: white,
                        alignment: Alignment.center,
                        child: Text(videoText,
                            style: const TextStyle(fontSize: 18)),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
