import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

CoinData coinData = CoinData();

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  String dropdownVal = 'USD';
  ValueNotifier<int> rate = ValueNotifier<int>(0);
  ValueNotifier<int> ethRate = ValueNotifier<int>(0);
  ValueNotifier<int> ltcRate = ValueNotifier<int>(0);
  initState() {
    super.initState();
    updateRate();
  }

  updateRate() async {
    var temp = await coinData.GetCurrentRate(dropdownVal);
    var temp1 = await coinData.GetETHCurrentRate(dropdownVal);
    var temp2 = await coinData.GetLTCCurrentRate(dropdownVal);
    rate.value = temp['rate'].toInt();
    ethRate.value = temp1['rate'].toInt();
    ltcRate.value = temp2['rate'].toInt();
  }

  DropdownButton getDropDown() {
    return DropdownButton<String>(
      value: dropdownVal,
      elevation: 20,
      dropdownColor: Colors.blueAccent,
      items: currenciesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          dropdownVal = value;
          updateRate();
        });
      },
    );
  }

  CupertinoPicker getPicker() {
    List<Widget> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 30.0,
      backgroundColor: Colors.lightBlue,
      magnification: 1.0,
      onSelectedItemChanged: (value) {
        setState(() {
          dropdownVal = currenciesList[value];
          updateRate();
          print(dropdownVal);
        });
      },
      children: pickerList,
    );
  }

  Widget build(BuildContext context) {
    print(rate);
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: ValueListenableBuilder(
                      valueListenable: rate,
                      builder: (BuildContext, ValueKey, _) {
                        print(ValueKey);
                        return Text(
                          rate == null
                              ? '1BTC = ?USD'
                              : '1 BTC = $ValueKey $dropdownVal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: ValueListenableBuilder(
                      valueListenable: ethRate,
                      builder: (BuildContext, ValueKey, _) {
                        print(ValueKey);
                        return Text(
                          rate == null
                              ? '1ETH = ?USD'
                              : '1 BTC = $ValueKey $dropdownVal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: ValueListenableBuilder(
                      valueListenable: ltcRate,
                      builder: (BuildContext, ValueKey, _) {
                        print(ValueKey);
                        return Text(
                          rate == null
                              ? '1LTC = ?USD'
                              : '1 BTC = $ValueKey $dropdownVal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getPicker() : getDropDown(),
          ),
        ],
      ),
    );
  }
}
