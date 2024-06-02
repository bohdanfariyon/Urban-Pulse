import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:urbanpulse/features/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:urbanpulse/features/SplashScreen/bloc/splash_bloc.dart';
import 'package:urbanpulse/features/Welcome/welcome_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(CheckUserEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToWelcome) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          } else if (state is SplashNavigateToMain) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return AnimatedSplashScreen(
              splash: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: LottieBuilder.asset("assets/gif/loading.json"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        "LOADING ...",
                        textStyle: const TextStyle(
                          fontSize: 40,
                          shadows: [
                            Shadow(color: Colors.black38, offset: Offset(1, 1)),
                          ],
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ],
              ),
              nextScreen: Container(), 
              splashIconSize: 300,
              backgroundColor: const Color.fromARGB(201, 150, 149, 149),
              duration: 4000, 
            );
          },
        ),
      ),
    );
  }
}
