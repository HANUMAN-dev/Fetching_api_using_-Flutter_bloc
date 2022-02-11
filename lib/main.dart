import 'package:apiget/repository/repository2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'views/tabbar.dart';
import 'repository/repository1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api-Get',
      //providing bloc to Home
      home: BlocProvider(
        create: (context) => DealBloc(
            dealRepository1: DealRepository1(),
            dealRepository2: DealRepository2()),
        //Stylead is created for navigation of tabbar
        child: const Stylead(),
      ),
    );
  }
}
