import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'Model/coinModel.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  List<Coin> coinModel = [];
  String selectedFromCurrency = '';
  String selectedToCurrency = '';
  double amount = 0.0;
  double convertedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    getCoinModel();
  }

  Future<void> getCoinModel() async {
    const url =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=20c54a77-5ee6-45ee-8045-bfce39349a00';
    try {
      var response = await get(Uri.parse(url), headers: {
        "content-Type": 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        List<dynamic> coinListData = jsonResponse['data'];

        List<Coin> coinModels =
            coinListData.map((coinData) => Coin.fromJson(coinData)).toList();

        setState(() {
          coinModel = coinModels;
          selectedFromCurrency = coinModel[0].symbol;
          selectedToCurrency = coinModel[1].symbol;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void convertCurrency() {
    Coin fromCoin =
        coinModel.firstWhere((coin) => coin.symbol == selectedFromCurrency);
    Coin toCoin =
        coinModel.firstWhere((coin) => coin.symbol == selectedToCurrency);

    double fromPrice = fromCoin.quote.usd.price;
    double toPrice = toCoin.quote.usd.price;

    setState(() {
      convertedAmount = (amount * (fromPrice / toPrice));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7971E),
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedFromCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFromCurrency = newValue!;
                });
              },
              items: coinModel.map<DropdownMenuItem<String>>((Coin coin) {
                return DropdownMenuItem<String>(
                  value: coin.symbol,
                  child: Text(coin.name),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedToCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  selectedToCurrency = newValue!;
                });
              },
              items: coinModel.map<DropdownMenuItem<String>>((Coin coin) {
                return DropdownMenuItem<String>(
                  value: coin.symbol,
                  child: Text(coin.name),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  amount = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                convertCurrency();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFf7971E))),
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            Text(
              'Converted Amount: $convertedAmount',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
