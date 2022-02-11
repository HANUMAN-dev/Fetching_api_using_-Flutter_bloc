import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../bloc/event_bloc.dart';
import 'block_deal.dart';
import 'bulk_deal.dart';

class Stylead extends StatefulWidget {
  const Stylead({Key? key}) : super(key: key);

  @override
  State<Stylead> createState() => _StyleadState();
}

class _StyleadState extends State<Stylead> {
  TextEditingController controller = TextEditingController();
  late DealBloc _restaurantBloc;
  late Size size;
  @override
  void initState() {
    super.initState();
    _restaurantBloc = BlocProvider.of<DealBloc>(context);
    //fetching api using bloc
    _restaurantBloc.add(FetchEvent1());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  const TabBar(
                    indicatorColor: Colors.deepOrangeAccent,
                    tabs: [
                      Text(
                        "Bulk Deal",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      Text(
                        "Block Deal",
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        //TabBars
        body: const TabBarView(
          children: [
            BlockDeal(),
            BulkDeal(),
          ],
        ),
      ),
    );
  }
}
