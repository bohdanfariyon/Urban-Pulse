import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:urbanpulse/repositories/user/abstract_user_reposity.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBlocBloc() : super(LoginBlocInitial()) {
    on<OnLogin>((event, emit) async {
      // ignore: unnecessary_null_comparison
      if (event.email==null || event.password==null){
        emit(IncorrectlyEntered());
      }else{
        emit(Loading());
        final isLogin=await GetIt.I<AbstractUserReposity>().login(event.email, event.password);
        emit(IsSuccessfulAuthorization(isLogin: isLogin));
      }
    });
  }
}
