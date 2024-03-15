import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.fit});
  final BoxFit? fit;

  static const _logo = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _logo,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage(
                  _logo,
                ),
                fit: fit)),
      ),
    );
  }
}
