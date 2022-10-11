import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/model/hivemodel.dart';
import 'package:workshop/view/homescreen.dart';
import 'package:path_provider/path_provider.dart';
import '../bloc/api_bloc/api_bloc.dart';
import 'package:hive/hive.dart';

import 'bloc/hive_bloc/hive_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  Hive.registerAdapter(HiveModelAdapter());
  await Hive.openBox<HiveModel>("location");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ApiBloc(),
      ),
      BlocProvider(
        create: (context) => HiveBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
