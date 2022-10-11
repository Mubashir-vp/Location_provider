import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:workshop/bloc/hive_bloc/hive_bloc.dart';
import 'package:workshop/model/hivemodel.dart';

class LocalDataScreen extends StatelessWidget {
  const LocalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _hiveBloc.add(const LoadHiveData());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HiveBloc, HiveState>(
          bloc: _hiveBloc,
          builder: (context, state) {
            if (state is HiveDataLoaded) {
              return Center(
                child: ListView.separated(
                  separatorBuilder: ((context, index) => const SizedBox()),
                  itemBuilder: (context, index) {
                    final key = state.keys[index];
                    final HiveModel? hiveModel = _box.get(key);
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        color: Colors.blue,
                        elevation: 12,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                hiveModel!.displayname,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                hiveModel.lat,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                hiveModel.lon,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                hiveModel.hamlet,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                hiveModel.iso,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.keys.length,
                ),
              );
            } else if (state is EmptyState) {
              return const Center(
                child: Text(
                  "No data saved",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return Container(
                color: Colors.red,
              );
            }
          },
        ),
      ),
    );
  }
}

HiveBloc _hiveBloc = HiveBloc();
Box<HiveModel> _box = Hive.box("location");
