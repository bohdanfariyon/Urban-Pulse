import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:urbanpulse/components/custom_error_SnackBar.dart';
import 'package:urbanpulse/features/EditUserProfile/bloc/edit_user_profile_bloc.dart';
import 'package:urbanpulse/features/EditUserProfile/components/edit_user_profile_custom_widget_input_field.dart';

import 'package:urbanpulse/repositories/repositories.dart';

class EditUserProfileForm extends StatefulWidget {
  EditUserProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  State<EditUserProfileForm> createState() => _EditUserProfileFormState();
}

class _EditUserProfileFormState extends State<EditUserProfileForm> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    try {
      final user = GetIt.I<AbstractUserReposity>().getUser();
      firstnameController.text = user!.firstname;
      lastnameController.text = user.lastname;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
    final bloc = EditUserProfileBloc();
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<EditUserProfileBloc, EditUserProfileState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ErrorNoConnection) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final snackBar =
                  CustomErrorSnackBar(errorMessage: "No connection");
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          } else if (state is ErrorNoCorrectData) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final snackBar = CustomErrorSnackBar(
                  errorMessage: "Please enter correct data");
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          } else if (state is UpdataUserDataSuccessfull) {
            Navigator.of(context).pop(true);
          }
        },
        child: Form(
          child: Column(
            children: [
              CustomFiledInput(
                controller: firstnameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'Enter first name',
                prefixIcon: Icons.person,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CustomFiledInput(
                  controller: lastnameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  hintText: 'Enter last name',
                  prefixIcon: Icons.person,
                ),
              ),
              const SizedBox(height: 16 / 2),
              BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
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
                      bloc.add(OnSave(
                          newFirstname: firstnameController.text,
                          newLastname: lastnameController.text));
                    },
                    child: Text(
                      "SAVE",
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
