part of 'choose_city_bloc.dart';

sealed class ChooseCityState extends Equatable {
  const ChooseCityState();
  
  @override
  List<Object> get props => [];
}

final class ChooseCityInitial extends ChooseCityState {}

class SelectedRegionSuccess extends ChooseCityState{}

class ErrorSelectedRegion  extends ChooseCityState{}

class ErrorSelecedRegionByGeolocation extends ChooseCityState{}

class LoadingByGeolocation extends ChooseCityState{}
class LoadingBySelect extends ChooseCityState{}