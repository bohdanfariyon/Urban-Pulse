import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:urbanpulse/features/UserProfile/bloc/profile_bloc.dart';
import 'package:urbanpulse/repositories/user/abstract_user_reposity.dart';
import 'package:urbanpulse/router/app_routes.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}


class _UserProfileScreenState extends State<UserProfileScreen> {
  final bloc =ProfileBloc();
  @override
  void initState() {
    super.initState();
    bloc.add(OnLoadData());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: bloc,
          builder: (context, state) {
            if(state is LoadedData){
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    const ProfilePic(),
                    const SizedBox(height: 20),
                    Text(
                      '${state.firstname} ${state.lastname}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ProfileMenu(
                      text: "My Account",
                      icon: "assets/icons/User Icon.svg",
                      press: () async {
                        await Navigator.of(context).pushNamed(AppRoutes.mobileedituserprofile);
                        bloc.add(OnLoadData());
                      },
                    ),
                    ProfileMenu(
                      text: "Notifications",
                      icon: "assets/icons/Bell.svg",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Settings",
                      icon: "assets/icons/Settings.svg",
                      press: () {
                        Navigator.of(context).pushNamed(AppRoutes.settings);
                      },
                    ),
                    ProfileMenu(
                      text: "Help Center",
                      icon: "assets/icons/Question mark.svg",
                      press: () {
                        Navigator.of(context).pushNamed(AppRoutes.helpcenter);
                      },
                    ),
                    ProfileMenu(
                      text: "Log Out",
                      icon: "assets/icons/Log out.svg",
                      press: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                          content: Text("Do you really want to log out?"),
                          
                          
                          
                          actions: [
                            TextButton(
                              child: const Text('No'),
                              
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              
                              onPressed: () {
                                GetIt.I<AbstractUserReposity>().logOut();
                                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.welcome,(Route<dynamic> route) => false,);
                              },
                            ),
                          ],
                        );
                          });
                        
                        
                      },
                    ),
                  ],
                ),
              );
            } if(state is Loading){
              return const Center(child: CircularProgressIndicator());
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }
}
