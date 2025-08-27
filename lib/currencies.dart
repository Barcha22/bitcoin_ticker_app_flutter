import 'package:http/http.dart';
import 'dart:convert';

const List<String> currencyList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
  'PKR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

class CoinData {
  Future<Map<String, dynamic>> getCoinData(String country) async {
    final countryFormatted = country.toLowerCase();
    final Map<String, dynamic> coinData = {};

    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,litecoin&vs_currencies=$countryFormatted',
    );

    try {
      Response response = await get(url);

      if (response.statusCode == 200) {
        // print('API fetched successfully');

        final decoded = jsonDecode(response.body);

        coinData['BTC'] = decoded['bitcoin']?[countryFormatted];
        coinData['ETH'] = decoded['ethereum']?[countryFormatted];
        coinData['LTC'] = decoded['litecoin']?[countryFormatted];
      }
    } catch (e) {
      // print('Error fetching coin data: $e');
    }

    return coinData;
  }
}
