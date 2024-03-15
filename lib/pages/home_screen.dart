import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lip_reader/pages/boarding_screen.dart';
import 'package:lip_reader/providers/main_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/app_logo.dart';

const lightGray = Color.fromARGB(255, 239, 239, 239);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const Expanded(flex: 2, child: AppLogo(fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<MainProvider>(builder: (__, prov, _) {
                  return InkWell(
                    onTap: () => prov.pickVideo(context),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * .4,
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: lightGray,
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Container(
                              height: 70,
                              width: 70,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    Color(0xff26CBFF),
                                    Color(0xff6980FD)
                                  ])),
                              child: const Center(
                                  child: Icon(
                                Icons.videocam_rounded,
                                color: Colors.white,
                              ))),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const Expanded(child: SizedBox())
            ],
          ),
          Positioned(
            right: 30,
            top: 30,
            child: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (_) => const BoardingScr()));
              },
              icon: const Icon(
                color: Colors.white,
                Icons.logout,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
