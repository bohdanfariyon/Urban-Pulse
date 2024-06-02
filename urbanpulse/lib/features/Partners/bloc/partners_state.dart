// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'partners_bloc.dart';

abstract class PartnersState extends Equatable {
  const PartnersState();

  @override
  List<Object> get props => [];
}

class PartnersInitial extends PartnersState {}

class PartnersLoading extends PartnersState {}

class PartnersLoaded extends PartnersState {
  final List<BusinessWidget> businesses;
  final String selectedFilter;
  final String selectedSortOption;
  final String selectedSortDirection; 
  PartnersLoaded({
    required this.businesses,
    required this.selectedFilter,
    required this.selectedSortOption,
    required this.selectedSortDirection,
  });
  

  @override
  List<Object> get props => [businesses,selectedFilter,selectedSortOption,selectedSortDirection];
}

class PartnersError extends PartnersState {}