import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../key/apikey.dart';
import '../model/deal_model.dart';

class DealRepository1 {
  @override
  Future<Deal> getDealData() async {
    //Getting bulk Data from api
    final response = await http.get(Uri.parse(DealStrings.bulkdealUrl));

    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return Deal.fromJson(jsonDecode(responseString));
    } else {
      print("EEEE");
      // thows exception if Fails
      throw Exception();
    }
  }
}
