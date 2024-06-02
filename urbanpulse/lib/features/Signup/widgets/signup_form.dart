import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbanpulse/components/custom_error_SnackBar.dart';
import 'package:urbanpulse/components/custom_success_SnackBar.dart';
import 'package:urbanpulse/features/Signup/bloc/sign_up_bloc.dart';
import 'package:urbanpulse/features/Signup/widgets/aler_dialog_virify_email.dart';
import 'package:urbanpulse/features/Signup/widgets/already_have_an_account_check.dart';
import 'package:urbanpulse/features/Signup/widgets/sign_up_custom_form_field.dart';

import 'package:urbanpulse/router/app_routes.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  bool verify = false;
  int code = generateRandomDigits();
  final bloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is ErrorEmailSend) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlsertDialogVerifyEmail(
                        title: state.title, content: state.content);
                  });
            });
          } else if (state is IncorectEmail) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlsertDialogVerifyEmail(
                        title: state.title, content: state.content);
                  });
            });
          } else if (state is SentEmailSuccessfully) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlsertDialogVerifyEmail(
                        title: state.title, content: state.content);
                  });
            });
          } else if (state is PleaseInputCode) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final snackBar = CustomErrorSnackBar(
                  errorMessage: "Incorrectly entered email code");
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          } else if (state is PleaseFillFields) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final snackBar =
                  CustomErrorSnackBar(errorMessage: state.errorMessage);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          } else if (state is SuccessfullyRegistered) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final successSnackBar =
                  CustomSuccessSnackBar(successMessage: state.message);
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.choosecity1,(Route<dynamic> route) => false,);
            });
          } else if (state is AlreadyExists) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final snackBar =
                  CustomErrorSnackBar(errorMessage: state.errorMessage);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          }
        },
        child: Form(
          child: Column(
            children: [
              CustomTextFormField(
                controller: firstnameController,
                textInputAction: TextInputAction.next,
                hintText: "Your firstname",
                prefixIcon: Icons.person,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16 / 50),
                child: CustomTextFormField(
                  controller: lastnameController,
                  textInputAction: TextInputAction.next,
                  hintText: "Your lastname",
                  prefixIcon: Icons.person,
                ),
              ),
              CustomTextFormField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hintText: "Your email",
                prefixIcon: Icons.person,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16 / 32),
                child: CustomTextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  hintText: "Your password",
                  prefixIcon: Icons.lock,
                ),
              ),
              CustomTextFormField(
                controller: codeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                hintText: "Code",
                prefixIcon: Icons.code,
              ),
              const SizedBox(height: 16 / 2),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  if (state is LoadingVerify) {
                    return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: null,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ));
                  } else if(state is LoadingSignUp){
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: null,
                      child: Text(
                        "Verify email".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    onPressed: () async {
                      code = generateRandomDigits();
                      bloc.add(OnVerifyEmail(code, usernameController.text));
                    },
                    child: Text(
                      "Verify email".toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16 / 2),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  if(state is LoadingSignUp){
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
                  } else if (state is LoadingVerify){
                    return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    onPressed: null,
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                  }
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    onPressed: () async {
                      int codeInput;
                      try {
                        codeInput = int.parse(codeController.text);
                      } catch (e) {
                        codeInput = 0;
                      }
                      bloc.add(OnRegister(
                        firstname: firstnameController.text,
                        lastname: lastnameController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                        code: code,
                        codeInput: codeInput,
                      ));
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int generateRandomDigits() {
  final random = Random();
  return random.nextInt(900000) + 100000;
}
