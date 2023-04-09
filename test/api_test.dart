import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:neversitup_exam/_model/currency_btc.dart';
import 'package:neversitup_exam/home_page/home_controller.dart';

import 'api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late String sampleData;

  // Setup data for testing
  setUp(() async {
    mockClient = MockClient();
    sampleData = await File("test_resources/sample_data.json").readAsString();
  });

  test("fetching data from api is completed", () async {
    // Use Mockito to return a 200 response when call an API.
    when(
      mockClient.get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"))
      ).thenAnswer((_) async => http.Response(sampleData, 200));
    
    expect(await fetchData(mockClient), isA<CurrencyBTC>());
  });

  test("fetching data from api is not completed, and get an error", () async {
    // Use Mockito to return a 404 response when call an API.
    when(
      mockClient.get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"))
      ).thenAnswer((_) async => http.Response("Not Found", 404));
    
    expect(fetchData(mockClient), throwsException);
  });
}