import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbanpulse/components/custom_error_SnackBar.dart';
import 'package:urbanpulse/components/custom_success_SnackBar.dart';
import 'package:urbanpulse/features/Settings/Screens/Change_password/bloc/change_password_bloc.dart';
import 'package:urbanpulse/features/Settings/Screens/Change_password/widgets/change_password_form_field.dart';

class ChangePasswordForm extends StatefulWidget {
  ChangePasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final current_password = TextEditingController();
  final new_password = TextEditingController();
  final new_password_again = TextEditingController();
  final bloc = ChangePasswordBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ErrorEnterNewPassword) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final snackBar = CustomErrorSnackBar(
                  errorMessage: "Enter the correct new password");
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
            });
          } else if (state is ErrorEnterCurrentPassword) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final snackBar = CustomErrorSnackBar(
                  errorMessage: "The old password was entered incorrectly");
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          } else if (state is PasswordChangedSuccessful) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final successSnackBar = CustomSuccessSnackBar(
                  successMessage: "Password changed successfully");
              ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
              Navigator.of(context).pop(true);
            });
          }
        },
        child: Form(
          child: Column(
            children: [
              PasswordFormField(
                controller: current_password,
                hintText: "Current Password",
                textInputAction: TextInputAction.next,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: PasswordFormField(
                  controller: new_password,
                  hintText: "New password",
                  textInputAction: TextInputAction.next,
                ),
              ),
              PasswordFormField(
                controller: new_password_again,
                hintText: "Repeat the password",
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 25 ),
              BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                bloc:bloc,
                builder: (context, state) {
                  if(state is Loading){
                    return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: null,
                    child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.white))
                  );
                  }
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      bloc.add(OnChangePassword(new_password: new_password.text, new_password_again: new_password_again.text, current_password: current_password.text));
                    },
                    child: Text(
                      "Save password",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
