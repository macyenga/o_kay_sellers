import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_kay_sellers/authentication/screens/authentication_screen.dart';
import 'package:o_kay_sellers/constants/colors.dart';
import 'package:o_kay_sellers/home/screens/home_screen.dart';
import 'package:o_kay_sellers/home/screens/home_screen_no_approve.dart';
import 'package:o_kay_sellers/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final ap = context.read<AuthenticationProvider>();

    super.initState();

    Timer(const Duration(seconds: 2), () async {
      if (!ap.isSignedIn) {
        Navigator.pushReplacementNamed(context, AuthenticationScreen.routeName);
      } else {
        await ap
            .getUserDataFromFirestore(FirebaseAuth.instance.currentUser!.uid);

        if (ap.isApproved) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(
              context, HomeScreenNoApprove.routeName);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 2, 214),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash.png'),
              ),
            ),
          ),
          const Positioned(
            bottom: 50,
            child: CupertinoActivityIndicator(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
