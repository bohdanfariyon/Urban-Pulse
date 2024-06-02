import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:urbanpulse/repositories/user/abstract_user_reposity.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckUserEvent>(_onCheckUser);
  }

  void _onCheckUser(CheckUserEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(Duration(seconds: 4));
    try {
      final user = GetIt.I<AbstractUserReposity>().getUser();
      if (user == null) {
        emit(SplashNavigateToWelcome());
      } else {
        emit(SplashNavigateToMain());
      }
    } catch (e) {
      emit(SplashNavigateToWelcome());
    }
  }
}
