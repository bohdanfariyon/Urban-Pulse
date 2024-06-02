import 'package:flutter/material.dart';
import 'package:urbanpulse/features/EditUserProfile/components/edit_user_profile_form.dart';



class MobileEditUserProfileScreen extends StatelessWidget {
  const MobileEditUserProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Profile'),
      ),
      body:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16.0),
              SizedBox(
                
                child:Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: EditUserProfileForm(),
                  ),
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}



