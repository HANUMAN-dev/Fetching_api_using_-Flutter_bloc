import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/bloc.dart';
import '../bloc/event_bloc.dart';
import '../bloc/state_bloc.dart';
import '../model/deal_model.dart';

class BulkDeal extends StatefulWidget {
  const BulkDeal({Key? key}) : super(key: key);

  @override
  State<BulkDeal> createState() => _BulkDealState();
}

class _BulkDealState extends State<BulkDeal> {
  TextEditingController controller = TextEditingController();
  late DealBloc _DealBloc;
  late Size size;
  @override
  void initState() {
    super.initState();
    _DealBloc = BlocProvider.of<DealBloc>(context);
    _DealBloc.add(FetchEvent2());
  }

  List<Data>? searchlist = [];
  List<Data>? searchlist2 = [];
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  @override
  void dispose() {
    super.dispose();
  }

  bool isPressedAll = true;
  bool isPressedBuy = false;
  bool isPressedSell = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            child: BlocListener<DealBloc, DealState>(
              listener: (context, state) {
                if (state is DealFailState) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: BlocBuilder<DealBloc, DealState>(
                builder: (context, state) {
                  if (state is DealLoadingState) {
                    return _buildLoading();
                  } else if (state is DealSuccessState) {
                    return buildArticleList(state.DealModel);
                  } else if (state is DealFailState) {
                    return _buildErrorUi(state.message);
                  }
                  return Container();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildArticleList(Deal DealModel) {
    //asas is List  of data of Type Data
    List<Data>? asas = DealModel.data;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0.0, 8.0, 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ElevatedButton(
                              onPressed: () {
                                searchlist = asas;
                                print(searchlist!.length);
                                setState(() {
                                  isPressedAll = true;
                                  isPressedBuy = false;

                                  isPressedSell = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 12, bottom: 12),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      color: isPressedAll
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  width: isPressedAll ? 3.0 : 0,
                                  color: Colors.black,
                                ),
                                primary:
                                    const Color.fromARGB(255, 148, 142, 126),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ElevatedButton(
                              onPressed: () {
                                searchlist = asas!
                                    .where(
                                        (element) => element.dealType == "BUY")
                                    .toList();
                                print(searchlist!.length);

                                setState(() {
                                  isPressedBuy = true;
                                  isPressedAll = false;
                                  isPressedSell = false;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 12, bottom: 12),
                                child: Text(
                                  'Buy',
                                  style: TextStyle(
                                      color: isPressedBuy
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  width: isPressedBuy ? 3.0 : 0,
                                  color: Colors.black,
                                ),
                                primary: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: ElevatedButton(
                              onPressed: () {
                                searchlist = asas!
                                    .where(
                                        (element) => element.dealType == "SELL")
                                    .toList();
                                print(searchlist!.length);

                                setState(() {
                                  isPressedAll = false;
                                  isPressedBuy = false;

                                  isPressedSell = true;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 12, bottom: 12),
                                child: Text(
                                  'Sell',
                                  style: TextStyle(
                                      color: isPressedSell
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  width: isPressedSell ? 3.0 : 0,
                                  color: Colors.black,
                                ),
                                shadowColor: Colors.black,
                                primary: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        searchlist = asas!
                            .where((element) => element.clientName!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                        setState(() {});
                      },
                      textAlign: TextAlign.center,
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Search Client name ',
                        hintStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                )),
            preferredSize: const Size(0.0, 80.0),
          ),
        ),
        body: Container(
            child: searchlist!.isEmpty
                ? ListView.builder(
                    itemCount: controller.text.isNotEmpty
                        ? searchlist2!.length
                        : asas!.length,
                    itemBuilder: (context, index) {
                      print(searchlist!.length);
                      return Column(
                        children: [
                          Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                      top: 4,
                                    ),
                                    child: Card(
                                      elevation: 1,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 3, bottom: 3, left: 2),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                                width: 3.5,
                                                color: asas![index].dealType ==
                                                        "BUY"
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 13,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      totTitle(asas[index]
                                                          .clientName!
                                                          .toLowerCase()),
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 10,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: Text(
                                                      //asas[index].dealDate.toString(),
                                                      DateFormat.d().format(
                                                              DateTime.parse(asas[
                                                                      index]
                                                                  .dealDate
                                                                  .toString())) +
                                                          " " +
                                                          DateFormat.yMMM()
                                                              .format(DateTime
                                                                  .parse(asas[
                                                                          index]
                                                                      .dealDate
                                                                      .toString())),
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 7, 17, 22),
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                      ),
                                                      child: asas[index].dealType ==
                                                              "BUY"
                                                          ? Text.rich(TextSpan(
                                                              text:
                                                                  "Bought ${asas[index].quantity} shares",
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .green),
                                                              children: <
                                                                  InlineSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        ' @ Rs ${asas[index].tradePrice}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black54),
                                                                  )
                                                                ]))
                                                          : Text.rich(TextSpan(
                                                              text:
                                                                  "Sold ${asas[index].quantity} shares",
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .red),
                                                              children: <
                                                                  InlineSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        ' @ Rs ${asas[index].tradePrice}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black54),
                                                                  )
                                                                ]))),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Values  Rs  ${(double.parse(asas[index].value!) * 0.0000001).toStringAsFixed(1)} cr",
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 30, 72, 211)),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: searchlist!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                      top: 4,
                                    ),
                                    child: Card(
                                      elevation: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 3, bottom: 3, left: 2),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                                width: 3.5,
                                                color: searchlist![index]
                                                            .dealType ==
                                                        "BUY"
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 13,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      totTitle(
                                                          searchlist![index]
                                                              .clientName!
                                                              .toLowerCase()),
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 10,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                    child: Text(
                                                      //asas[index].dealDate.toString(),
                                                      DateFormat.d().format(
                                                              DateTime.parse(asas![
                                                                      index]
                                                                  .dealDate
                                                                  .toString())) +
                                                          " " +
                                                          DateFormat.yMMM().format(
                                                              DateTime.parse(
                                                                  searchlist![
                                                                          index]
                                                                      .dealDate
                                                                      .toString())),
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 7, 17, 22),
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                      ),
                                                      child: searchlist![index]
                                                                  .dealType ==
                                                              "BUY"
                                                          ? Text.rich(TextSpan(
                                                              text:
                                                                  "Bought ${searchlist![index].quantity} shares",
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .green),
                                                              children: <
                                                                  InlineSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        ' @ Rs ${searchlist![index].tradePrice}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black54),
                                                                  )
                                                                ]))
                                                          : Text.rich(TextSpan(
                                                              text:
                                                                  "Sold ${searchlist![index].quantity} shares",
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .red),
                                                              children: <InlineSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        ' @ Rs ${searchlist![index].tradePrice}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black54),
                                                                  )
                                                                ]))),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Values  Rs  ${(double.parse(searchlist![index].value!) * 0.0000001).toStringAsFixed(1)} cr",
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 30, 72, 211)),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  )));
  }

  String totTitle(String input) {
    final List<String> splitStr = input.split(' ');
    for (int i = 0; i < splitStr.length; i++) {
      splitStr[i] =
          '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1)}';
    }
    final output = splitStr.join(' ');
    return output;
  }

  Widget _buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
