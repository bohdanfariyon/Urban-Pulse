import 'package:flutter/material.dart';
import 'package:urbanpulse/features/Settings/Screens/Change_password/widgets/change_password_form.dart';



class ChangePassword extends StatelessWidget {
  const ChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16.0),
              SizedBox(
                
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: ChangePasswordForm(),
                  ),
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}



