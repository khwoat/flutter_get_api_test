import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:neversitup_exam/_model/currency_btc.dart';

class HomeController extends GetxController {

  late Rx<Future<CurrencyBTC>> currencyBTC;

  late final Timer? timer;

  @override
  void onInit() {
    // Assign value for Rx type
    currencyBTC = fetchData().obs;

    // Fetch data every 1 minute
    timer = Timer.periodic(const Duration(minutes: 1), (timer) => currencyBTC.value = fetchData());

    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
  
  // Fetch currency data from API 
  Future<CurrencyBTC> fetchData() async {
    print("fetching data...");
    String apiPath = "https://api.coindesk.com/v1/bpi/currentprice.json";
    http.Response response =  await http.get(Uri.parse(apiPath));

    // If status code is not 200, throw an error
    if (response.statusCode == 200){
      return CurrencyBTC.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Can not fetch data from $apiPath");
    }
  }
  
}