// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbanpulse/features/Login/bloc/login_bloc_bloc.dart';
import 'package:urbanpulse/features/Login/widgets/already_have_an_account_check.dart';
import 'package:urbanpulse/features/Login/widgets/login_form_custom_form_field.dart';
import 'package:urbanpulse/components/custom_error_SnackBar.dart';
import 'package:urbanpulse/router/app_routes.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
  });
  String username='';
  String password='';
  final bloc = LoginBlocBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<LoginBlocBloc, LoginBlocState>(
        listener: (context, state) {
          if (state is IsSuccessfulAuthorization) {
            if (state.isLogin) {
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainpage,(Route<dynamic> route) => false,);
            } else {
              final snackBar =
                  CustomErrorSnackBar(errorMessage: 'Incorrectly entered login or password');
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else if (state is IncorrectlyEntered ) {
            final snackBar = CustomErrorSnackBar(
                errorMessage: 'Incorrectly entered login or password');
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Form(
          child: Column(
            children: [
              CustomTextField(
                prefixIcon: Icons.person,
                hintText: "Your email",
                onChanged: (value) {
                  username = value;
                },
                textInputAction: TextInputAction
                    .next, // Передаємо значення для textInputAction
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CustomTextField(
                  prefixIcon: Icons.lock,
                  hintText: "Your password",
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 16),
              Hero(
                tag: "login_btn",
                child: BlocBuilder<LoginBlocBloc, LoginBlocState>(
                  bloc:bloc,
                  builder: (context, state) {

                    if(state is Loading){
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: null,
                        child: CircularProgressIndicator(
                                valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
                                )
                      );
                    }
                    return ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                        ),
                      onPressed: () {
                        bloc.add(
                            OnLogin(email: username, password: password));
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.signup);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
