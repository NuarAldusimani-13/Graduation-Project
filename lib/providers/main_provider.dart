// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lip_reader/file_picker_helper.dart';
import 'package:lip_reader/pages/home_screen.dart';
import 'package:lip_reader/remote_services/dio_helper.dart';
import 'package:lip_reader/remote_services/dio_services.dart';
import 'package:lip_reader/screen_loading.dart';
import 'package:video_player/video_player.dart';

import '../bottom_sheet/show_bottom_sheet.dart';
import '../helper.dart';
import '../pages/video_screen.dart';

const maxVideoDur = 6;

class MainProvider extends ChangeNotifier {
  Future<String?> _analyzeVideo(BuildContext context) async {
    final source = await ShowBottomSheet(context).selectImageSource();
    if (source == null) return null;
    final path = source == ImageSource.camera
        ? await FilePickerHelper.recordVideo()
        : await FilePickerHelper.pickVideo();
    return path;
  }

  VideoPlayerController? videoCtrl;

  Future<void> pickVideo(BuildContext context) async {
    try {
      final path = await _analyzeVideo(context);
      if (path == null) return;

      videoCtrl = VideoPlayerController.file(File(path));
      await videoCtrl!.initialize();
      notifyListeners();

      if (videoCtrl!.value.duration.inSeconds > maxVideoDur) {
        // log('Video must be maximum $maxVideoDur secondes');
        Helper.showToast('Video must be maximum $maxVideoDur secondes');
        return;
      }
      await videoCtrl!.play();
      await videoCtrl!.setLooping(true);

      if (!context.mounted) return;
      Navigator.push(context,
              CupertinoPageRoute(builder: (_) => VideoScreen(videoCtrl!)))
          .then((_) {
        videoCtrl!.dispose();
      });
      await _processVideo();
    } catch (e) {
      log('pickVideo Err $e');
      Helper.showToast('$e');
    }
  }

  reProcessVideo() => _processVideo();

  String? videoText;

  _processVideo() async {
    try {
      ScreenLoading.show('Video Scanning');
      final path = videoCtrl!.dataSource.replaceFirst('file://', '');
      final response = await DioServices.uploadVideo(path);
      log('${response.runtimeType} response is! Map ${response is! Map} response $response');
      if (response is! Map) {
        throw Exception('${DioHelper.statusCodeCallback(-1)} $response');
      }
      videoText = response['transcript'].toString();
      notifyListeners();
      // log("response['transcript'] ${response['transcript']} && videoText $videoText");
    } catch (e) {
      log('selectVideo Err $e');
      Helper.showToast('$e');
    } finally {
      ScreenLoading.dismiss;
    }
  }

  bool isLoading = false; // Add this variable to track loading state

  createUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      isLoading = true;
      // Set loading state to true when authentication begins
      notifyListeners();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (_) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Helper.showToast('The password provided is too weak.');
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        Helper.showToast('The account already exists for that email.');
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Helper.showToast(e.toString());
    } finally {
      isLoading =
          false; // Set loading state to false when authentication completes
      notifyListeners();
    }
  }

  login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      isLoading = true; // Set loading state to true when authentication begins
      notifyListeners();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (_) => const HomeScreen()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Helper.showToast(e.toString());
    } finally {
      isLoading =
          false; // Set loading state to false when authentication completes
      notifyListeners();
    }
  }
}
