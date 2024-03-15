import 'package:flutter_easyloading/flutter_easyloading.dart';


class ScreenLoading {
  const ScreenLoading();

  static Future<void> show([String? message = 'loading']) => EasyLoading.show(
        status: '$message...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );

  static Future<void> get dismiss => EasyLoading.dismiss();

  static Future<void> showSuccess(String message) =>
      EasyLoading.showSuccess(message, dismissOnTap: true);

  static Future<void> get showError =>
      EasyLoading.showError('Failed with Error');

  static Future<void> showInfo() => EasyLoading.showInfo('Useful Information.');

  // static Future<void> showToast() => EasyLoading.showToast('Toast');

  // showProgress() {
  //   EasyLoading.showProgress(0.3, status: 'downloading...');
  // }
}
