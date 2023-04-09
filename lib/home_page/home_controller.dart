import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:neversitup_exam/_model/currency_btc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {

  late Rx<Future<CurrencyBTC>> currencyBTC;

  late final Timer? timer;

  @override
  void onInit() async {
    // Assign value for Rx type (First fetch)
    currencyBTC = fetchData().obs;
    await saveDataToSharedPreference(await currencyBTC.value);
    
    // Fetch and save data every 1 minute
    timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      currencyBTC.value = fetchData();
      await saveDataToSharedPreference(await currencyBTC.value);
    });

    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  // Save currency data to shared preference
  Future<void> saveDataToSharedPreference(CurrencyBTC currencyBTC) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Get data from sharedpreference and add new data
    String? data = sharedPreferences.getString("currency-data");
      var dataList = {};
      if (data != null && data != "") {
        dataList = jsonDecode(data);
      }
      dataList[currencyBTC.time.updated] = currencyBTC.bpi;

      String json = jsonEncode(dataList);
      await sharedPreferences.setString("currency-data", json);
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

  void gotoHistoryPage() {
    Get.toNamed("/history");
  }
  
}