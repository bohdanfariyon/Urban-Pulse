import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbanpulse/components/custom_error_SnackBar.dart';
import 'package:urbanpulse/features/ConnectionError/connection_error_screen.dart';
import 'package:urbanpulse/features/Complex/bloc/complex_bloc.dart';


class Complex extends StatefulWidget {
  final int id;

  const Complex({Key? key, required this.id}) : super(key: key);

  @override
  _ComplexState createState() => _ComplexState();
}

class _ComplexState extends State<Complex> {
  bool isFavorite = false;
  late int id;
  final bloc = ComplexBloc();

  @override
  void initState() {
    super.initState();
    id = widget.id;
    bloc.add(OnLoadDetailInformation(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.grey : null,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          bloc.add(OnLoadDetailInformation(id: id));
        },
        child: BlocBuilder<ComplexBloc, ComplexState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadedDetailedInformation) {
              final data = state.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundImage: AssetImage("assets/images/profile.jpg")
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          data.name,
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            data.category,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City:',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            data.city,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Working hours:',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            data.openingHours,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone number:',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            data.phone,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Website:',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            data.website,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              );
            } else if (state is ErrorLoaded) {
              return ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: Center(child: ConnectionErrorScreen()),
                  ),
                ],
              );
            } else if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: BlocListener<ComplexBloc, ComplexState>(
        bloc: bloc,
        listener: (context, state) {
          if(state is ErrorOpenGoogleMap){
            final snackBar = CustomErrorSnackBar(
                errorMessage: 'Unable to open Google Maps');
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            bloc.add(OnLoadDetailInformation(id: id));
          } else if (state is ErrorAccessToGeolocation){
            final snackBar = CustomErrorSnackBar(
                errorMessage: 'There is no access to geolocation');
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            bloc.add(OnLoadDetailInformation(id: id));
          }
          
        },
        child: BlocBuilder<ComplexBloc, ComplexState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadedDetailedInformation) {
              return FloatingActionButton(
                onPressed: () async {
                  bloc.add(
                      OnBuildARoute(lat: state.data.lat, lon: state.data.lon));
                },
                child: const Icon(Icons.map),
                backgroundColor: Colors.grey[300],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
