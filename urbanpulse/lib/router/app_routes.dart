import 'package:urbanpulse/features/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:urbanpulse/features/Choose_city/choose_city_screen.dart';
import 'package:urbanpulse/features/EditUserProfile/edit_user_profile_screen.dart';
import 'package:urbanpulse/features/HelpCenter/HelpCenter.dart';
import 'package:urbanpulse/features/HelpCenter/components/faq.dart';
import 'package:urbanpulse/features/Login/login_screen.dart';
import 'package:urbanpulse/features/Settings/Screens/Change_password/change_password.dart';
import 'package:urbanpulse/features/Settings/settings_screen.dart';
import 'package:urbanpulse/features/Signup/signup_screen.dart';
import 'package:urbanpulse/features/SplashScreen/SplashScreen.dart';
import 'package:urbanpulse/features/Welcome/welcome_screen.dart';

class AppRoutes {
  static final pages = {
    splash: (context) =>const SplashScreen(),
    welcome: (context) => const WelcomeScreen(),
    
    login: (context) => const LoginScreen(),
    signup:(context)=>const SignUpScreen(),
    choosecity1:(context) => const ChooseCity(1),
    choosecity2:(context) => const ChooseCity(2),
    mainpage:(context)=> const MainPage(),
    mobileedituserprofile:(context)=> const MobileEditUserProfileScreen(),
    changepassword:(context)=>const ChangePassword(),
    settings:(context)=>SettingsScreen(),
    faq:(context)=>const FAQ(),
    helpcenter:(context)=>HelpCenterScreen(),
    
  };
  static const splash='/splash';
  static const welcome ='/welcome';
  static const login ='/login';
  static const signup='/signup';
  static const choosecity1='choosecity1';
  static const choosecity2='choosecity2';
  static const mainpage='mainpage';
  static const mobileedituserprofile='mobileedituserprofile';
  static const changepassword='changepassword';
  static const settings='settings';
  static const faq='faq';
  static const helpcenter='helpcenter';
  
  
  
}