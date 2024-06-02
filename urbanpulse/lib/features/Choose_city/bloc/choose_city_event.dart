part of 'choose_city_bloc.dart';

sealed class ChooseCityEvent extends Equatable {
  const ChooseCityEvent();

  @override
  List<Object> get props => [];
}
class OnSelect extends ChooseCityEvent {
  final String location;

  OnSelect({required this.location});
}
class OnSelectByGeolocation extends ChooseCityEvent{
  
}