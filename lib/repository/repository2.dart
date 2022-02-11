import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../key/apikey.dart';
import '../model/deal_model.dart';

class DealRepository2 {
  @override
  Future<Deal> getDealData2() async {
    //Getting block Data from Api
    final response2 = await http.get(Uri.parse(DealStrings.blockdealUrl));

    if (response2.statusCode == 200) {
      List<int> bytes = response2.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return Deal.fromJson(jsonDecode(responseString));
    } else {
      print("EEEE");
      //Throws Exception if Fails
      throw Exception();
    }
  }
}
