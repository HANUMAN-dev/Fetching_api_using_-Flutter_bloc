//model according to our give api

class Deal {
  List<Data>? data;
  String? status;

  Deal({this.data, this.status});

  Deal.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    return data;
  }
}

class Data {
  String? finCode;
  String? clientName;
  String? dealType;
  String? quantity;
  String? value;
  String? tradePrice;
  String? dealDate;
  String? exchange;

  Data(
      {this.finCode,
      this.clientName,
      this.dealType,
      this.quantity,
      this.value,
      this.tradePrice,
      this.dealDate,
      this.exchange});

  Data.fromJson(Map<String, dynamic> json) {
    finCode = json['FinCode'];
    clientName = json['ClientName'];
    dealType = json['DealType'];
    quantity = json['Quantity'];
    value = json['Value'];
    tradePrice = json['TradePrice'];
    dealDate = json['DealDate'];
    exchange = json['Exchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FinCode'] = this.finCode;
    data['ClientName'] = this.clientName;
    data['DealType'] = this.dealType;
    data['Quantity'] = this.quantity;
    data['Value'] = this.value;
    data['TradePrice'] = this.tradePrice;
    data['DealDate'] = this.dealDate;
    data['Exchange'] = this.exchange;
    return data;
  }
}
