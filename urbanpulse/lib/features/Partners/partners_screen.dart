import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbanpulse/features/ConnectionError/connection_error_screen.dart';
import 'package:urbanpulse/features/Partners/bloc/partners_bloc.dart';
import 'package:urbanpulse/features/Partners/components/filter_dialog.dart';
import 'package:urbanpulse/router/app_routes.dart';

class PartnersScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartnersBloc()..add(LoadPartners(isDownload: false)),
      child: Builder(
        builder: (context) {
          final bloc = BlocProvider.of<PartnersBloc>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(201, 150, 149, 149),
              actions: [
                BlocBuilder<PartnersBloc, PartnersState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      onPressed: () {
                        if (state is PartnersLoaded) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FilterDialog(
                                initialFilter: state.selectedFilter,
                                initialSortOption: state.selectedSortOption,
                                initialSortDirection:
                                    state.selectedSortDirection,
                                onFilterChanged: (String? filterValue,
                                    String sortOption, String sortDirection) {
                                  bloc.add(UpdateFilter(
                                      filterValue!, sortOption, sortDirection));
                                },
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.location_on, color: Colors.black),
                  onPressed: () async {
                    final result = await Navigator.of(context)
                        .pushNamed(AppRoutes.choosecity2);
                    if (result == true) {
                      bloc.add(LoadPartners(isDownload: true));
                    }
                  },
                ),
              ],
              title: BlocBuilder<PartnersBloc, PartnersState>(
                bloc: bloc,
                builder: (context, state) {
                  bool enabled=true;
                  if(state is PartnersError){
                    enabled=false;
                  }
                  return TextField(
                    enabled: enabled,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name...',
                      hintStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (text) {
                      bloc.add(UpdateSearchQuery(text));
                    },
                  );
                },
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                bloc.add(LoadPartners(isDownload: true));
              },
              child: BlocBuilder<PartnersBloc, PartnersState>(
                builder: (context, state) {
                  if (state is PartnersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PartnersError) {
                    return ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height -
                              kToolbarHeight,
                          child: Center(child: ConnectionErrorScreen()),
                        ),
                      ],
                    );
                  } else if (state is PartnersLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.businesses.length,
                      itemBuilder: (context, index) {
                        return state.businesses[index];
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
