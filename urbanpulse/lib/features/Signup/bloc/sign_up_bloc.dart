
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:urbanpulse/repositories/repositories.dart';
import 'package:validators/validators.dart';
part "sign_up_event.dart";
part "sign_up_state.dart";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<OnVerifyEmail>((event, emit) async{
      if(isEmail(event.email)){
        
        emit(LoadingVerify());
        final bool isSend=await sendEmail(event.email, event.code);
        if(isSend==true){
          emit(SentEmailSuccessfully(email: event.email));
        }else{
          emit(ErrorEmailSend(email: event.email));
        }
      } else{
        emit(IncorectEmail());
      }
      
      
    });
    on<OnRegister>((event, emit) async {
      if(event.code==event.codeInput){
        if (event.firstname == '' || event.lastname == '' || event.username == '' || event.password == ''){
          emit(PleaseFillFields());
        } else {
          if(!isEmail(event.username)){
            emit(IncorectEmail());
          } else {
            emit(LoadingSignUp());
            bool isRegister= await GetIt.I<AbstractUserReposity>().registerUser(event.firstname, event.lastname, event.username, event.password);
            if(isRegister){
              emit(SuccessfullyRegistered());
            } else {
              emit(AlreadyExists());
            }
          }
        }
      } else{
        emit(PleaseInputCode());
      }
    });
  }
}

  Future<bool>sendEmail(String email, int code) async {
  String username = 'your_email_address'; // Ваша електронна адреса
  String password = 'your_password'; // Пароль від вашої пошти

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'App Tester')
    ..recipients.add(email)
    ..subject = 'UrbanPulse'
    ..html = '''
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          body {
            font-family: Arial, sans-serif;
            color: #333333;
          }
          p {
            font-size: 16px;
          }
          strong {
            font-size: 20px;
          }
        </style>
      </head>
      <body>
        <p>
          Вітаємо, реєстрація пройшла успішно! Раді, що скористалися нашим застосунком. Слава Україні!<br>
          Ваш код для верифікації: <strong>$code</strong>
        </p>cd
      </body>
      </html>
    ''';
// }
  try {
    // ignore: unused_local_variable
    final sendReport = await send(message, smtpServer);
    return true;
    
  }catch (e,st) {
    GetIt.I<Talker>().handle(e,st);
    return false;
    
  }
}

int generateRandomDigits() {
  Random random = Random();
  int result = 0;

  for (int i = 0; i < 6; i++) {
    int digit = random.nextInt(10); 
    result = result * 10 + digit;
  }

  return result;
}