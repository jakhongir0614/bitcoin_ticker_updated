import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = 'USD';
  DropdownButton<String> andriodDropdown() {
    List<DropdownMenuItem<String>> myCurrenciesList = [];
    for (String currency in currenciesList) {
      myCurrenciesList.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 30),
      value: selectedValue,
      items: myCurrenciesList,
      onChanged: (value) {
        setState(() {
          selectedValue = '$value';
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> myCurrenciesList = [];
    for (String currency in currenciesList) {
      myCurrenciesList.add(Text(
        currency,
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Colors.grey[300],
      magnification: 2.0,
      itemExtent: 32,
      onSelectedItemChanged: (selectedValue) {
        print(selectedValue);
      },
      children: myCurrenciesList,
    );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedValue);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards() {
    List<PriceContainer> priceContainers = [];
    for (String crypto in cryptoList) {
      priceContainers.add(
        PriceContainer(
          cryptoCurrency: crypto,
          selectedValue: selectedValue,
          value: '${isWaiting ? '?' : coinValues[crypto]}',
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: priceContainers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: kMargin,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Bitcoin Ticker',
                  style: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            decoration: kBoxShadow,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [makeCards()],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Platform.isIOS ? iOSPicker() : andriodDropdown(),
            ),
            decoration: kBoxShadow,
          ),
        ],
      ),
    );
  }
}

class PriceContainer extends StatelessWidget {
  PriceContainer({
    required this.value,
    required this.selectedValue,
    required this.cryptoCurrency,
  });
  final String value;
  final String selectedValue;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kMargin,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            '1 $cryptoCurrency = $value $selectedValue',
            style: TextStyle(
              color: Colors.black26,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
      decoration: kBoxShadow,
    );
  }
}
