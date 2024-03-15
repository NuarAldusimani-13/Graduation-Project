import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lip_reader/pages/home_screen.dart';
import 'package:lip_reader/pages/login_screen.dart';

import '../widgets/app_logo.dart';

const white = Color.fromRGBO(255, 255, 255, 76);
const darkClr = Color(0xff0D0D0D);

class BoardingScr extends StatelessWidget {
  const BoardingScr({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print({user: user});
    return Scaffold(
      backgroundColor: darkClr,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top, 20, 10),
            child: const Text(
              'Let’s get\nstarted!',
              style: TextStyle(
                  color: white, fontSize: 35, fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Bringing Silent Speech into Focus',
                style: TextStyle(color: white, fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .05),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const AppLogo(fit: BoxFit.fitHeight),
                MaterialButton(
                    minWidth: MediaQuery.sizeOf(context).width,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: white,
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => user != null
                                ? const HomeScreen()
                                : const LoginPage())),
                    child: const Text('Start Now',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
