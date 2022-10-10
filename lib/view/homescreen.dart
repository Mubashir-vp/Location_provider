
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocks/api_bloc/api_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _currentindex = 0;
final _formKey = GlobalKey<FormState>();

TextEditingController latcontroller = TextEditingController();
TextEditingController loncontroller = TextEditingController();
ApiBloc _apiBloc = ApiBloc();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ApiBloc, ApiState>(
          bloc: _apiBloc,
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 11),
                    child: TextFormField(
                      controller: latcontroller,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: loncontroller,
                      keyboardType: TextInputType.number,
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
                              _apiBloc.add(Searching());
                              _apiBloc.add(LoadData(
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
                  state is SearchingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state is DataLoaded
                          ? Center(
                              child: Card(
                                child: Column(
                                  children: [
                                    Text(state.model.displayName!),
                                    Text(state.model.lat!),
                                    Text(state.model.lon!),
                                    Text(state.model.address!.neighbourhood!),
                                    Text(state.model.address!.iso31662Lvl4!),
                                  ],
                                ),
                              ),
                            )
                          : state is ErrorState
                              ? Center(
                                  child: Text(
                                    state.errorMessage,
                                  ),
                                )
                              : const SizedBox()
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _currentindex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.searchengin,
                ),
                label: "Search"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.offline_pin,
              ),
              label: "Saved",
            ),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Get the location",
          ),
        ),
      ),
    );
  }
}
