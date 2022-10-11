import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workshop/model/hivemodel.dart';
import 'package:workshop/view/localdatascreen.dart';

import '../bloc/api_bloc/api_bloc.dart' as apibloc;
import '../bloc/hive_bloc/hive_bloc.dart' as hivebloc;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<apibloc.ApiBloc, apibloc.ApiState>(
        bloc: _apiBloc,
        builder: (context, state,) {
          return Scaffold(
            floatingActionButton: state is apibloc.DataLoaded
                ? BlocBuilder<hivebloc.HiveBloc, hivebloc.HiveState>(
                    bloc: _hiveBloc,
                    builder: (context, hiveState) {
                      return FloatingActionButton(
                          child: const Icon(Icons.save_alt_outlined),
                          onPressed: () {
                            _hiveBloc.add(
                              hivebloc.SaveData(
                                data: HiveModel(
                                  displayname: state.model.displayName!,
                                  lat: state.model.lat!,
                                  lon: state.model.lon!,
                                  hamlet: state.model.address!.hamlet!,
                                  iso: state.model.address!.iso31662Lvl4!,
                                ),
                              ),
                            );
                          });
                    },
                  )
                : FloatingActionButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Icon(Icons.disabled_by_default),
                  ),
            body: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 11),
                    child: TextFormField(
                      controller: latcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This Field Is Required";
                        } else if (RegExp(
                                r'^[a-z A-Z _\-=@,\.;( ,)[, ], {, }, *, +, ?, ., ^, $, |]+$,-')
                            .hasMatch(value)) {
                          return "Enter a correct value";
                        } else if (value[0] == "-") {
                          return "Enter a correct value";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(7)),
                        labelText: 'Enter the Lat',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 11),
                    child: TextFormField(
                      controller: loncontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This Field Is Required";
                        } else if (RegExp(
                          r'^[a-z A-Z _\-=@,\.;( ,)[, ], {, }, *, +, ?, ., ^, $, |]+$,-',
                        ).hasMatch(value)) {
                          return "Enter a correct value";
                        } else if (value[0] == "-") {
                          return "Enter a correct value";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(7)),
                        labelText: 'Enter the lon',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _apiBloc.add(apibloc.Searching());
                              _apiBloc.add(apibloc.LoadData(
                                  lat: latcontroller.text,
                                  lon: loncontroller.text));
                            }
                          },
                          child: const Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ),
                  ),
                  state is apibloc.SearchingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state is apibloc.DataLoaded
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Card(
                                  color: Colors.blue,
                                  elevation: 12,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          state.model.displayName!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          state.model.lat!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          state.model.lon!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          state.model.address!.hamlet!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          state.model.address!.iso31662Lvl4!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : state is apibloc.ErrorState
                              ? Center(
                                  child: Text(
                                    state.errorMessage,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : const SizedBox()
                ],
              ),
            )),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LocalDataScreen()),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.offline_pin,
                  ),
                )
              ],
              centerTitle: true,
              title: const Text(
                "Get the location",
              ),
            ),
          );
        },
      ),
    );
  }
}

final _formKey = GlobalKey<FormState>();
TextEditingController latcontroller = TextEditingController();
TextEditingController loncontroller = TextEditingController();
apibloc.ApiBloc _apiBloc = apibloc.ApiBloc();
hivebloc.HiveBloc _hiveBloc = hivebloc.HiveBloc();

const snackBar = SnackBar(
  content: Text('There is no data to save'),
);
