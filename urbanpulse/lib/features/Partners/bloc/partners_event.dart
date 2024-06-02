part of 'partners_bloc.dart';

abstract class PartnersEvent extends Equatable {
  const PartnersEvent();

  @override
  List<Object> get props => [];
}

class LoadPartners extends PartnersEvent {
  final bool isDownload;

  LoadPartners({required this.isDownload});
  @override
  List<Object> get props => [isDownload];
}

class UpdateFilter extends PartnersEvent {
  final String filter;
  final String sortOption;
  final String sortDirection;
  const UpdateFilter(this.filter,this.sortOption,this.sortDirection);

  @override
  List<Object> get props => [filter,sortOption,sortDirection];
}



class UpdateSearchQuery extends PartnersEvent {
  final String searchQuery;

  const UpdateSearchQuery(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}
