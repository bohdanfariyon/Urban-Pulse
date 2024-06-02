import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_it/get_it.dart';
import 'package:urbanpulse/components/custom_error_SnackBar.dart';
import 'package:urbanpulse/features/Choose_city/bloc/choose_city_bloc.dart';
import 'package:urbanpulse/repositories/repositories.dart';
import 'package:urbanpulse/router/app_routes.dart';

class ChooseCity extends StatefulWidget {
  final int requeslt;

  const ChooseCity(this.requeslt, {super.key});

  @override
  _ChooseCityState createState() => _ChooseCityState();
}

class _ChooseCityState extends State<ChooseCity> {
  final TextEditingController _controller = TextEditingController();
  List<double> boundingbox = [];
  String state = '';
  String country = '';
  late int myRequestValue;
  @override
  void initState() {
    super.initState();

    myRequestValue = widget.requeslt;
  }

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I<AbstractUserReposity>().getUser();

    String a, b;
    double toolBarH;
    if (myRequestValue == 1) {
      toolBarH=0;
    } else {
      toolBarH=kToolbarHeight;
    }
    if (user?.country == '') {
      a = "Country: None";
      
      b = "State: None";
    } else {
      a = "Country: ${user?.country}";
      
      b = "State: ${user?.state}";
    }
    final bloc = ChooseCityBloc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(201, 150, 149, 149),
        toolbarHeight: toolBarH
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<ChooseCityBloc, ChooseCityState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is ErrorSelectedRegion) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                final snackBar = CustomErrorSnackBar(
                    errorMessage: "Incorrectly_entered_region");
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }
            if (state is SelectedRegionSuccess) {
              if (myRequestValue == 1) {
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainpage,(Route<dynamic> route) => false,);
              } else {
                Navigator.of(context).pop(true);
                
              }
            }
            if (state is ErrorSelecedRegionByGeolocation) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                final snackBar = CustomErrorSnackBar(
                    errorMessage: "Location permission denied");
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  a,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  b,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(color: Colors.white),
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Enter region",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.location_on),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await getRegionSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion,
                        style: const TextStyle(
                          color: Colors.white, 
                        ),
                      ),
                      tileColor: Colors.black, 
                      
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    _controller.text = suggestion;
                  },
                ),
                const SizedBox(height: 20.0),
                BlocBuilder<ChooseCityBloc, ChooseCityState>(
                  builder: (context, state) {
                    if(state is LoadingBySelect){
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: null,
                        child: CircularProgressIndicator(
                                valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
                                )
                      );
                    } else if(state is LoadingByGeolocation){
                      return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: null,
                      child: const Text("Select",
                          style: TextStyle(color: Colors.white)),
                    );
                    }

                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () async {
                        bloc.add(OnSelect(location: _controller.text));
                      },
                      child: const Text("Select",
                          style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
                const SizedBox(height: 50.0),
                BlocBuilder<ChooseCityBloc, ChooseCityState>(
                  builder: (context, state) {
                    if (state is LoadingByGeolocation) {
                      return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: null,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ));
                    } else if(state is LoadingBySelect){
                      return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: null,
                      child: const Text(
                        "Select region by geolocation",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                    }
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        bloc.add(OnSelectByGeolocation());
                      },
                      child: const Text(
                        "Select region by geolocation",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
