part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashNavigateToWelcome extends SplashState {}

class SplashNavigateToMain extends SplashState {}