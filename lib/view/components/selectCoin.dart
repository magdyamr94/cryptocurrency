import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Model/coinModel.dart';

class SelectCoin extends StatefulWidget {
  var selectitem;
  SelectCoin({this.selectitem});
  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;
  void initState() {
    getCoinModel();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myhight = MediaQuery.of(context).size.height;
    double mywight = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFf7971E),
          title: Text('Currency details'),
        ),
        // backgroundColor: Colors.black,
        body: Container(
          height: myhight,
          width: mywight,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mywight * 0.03, vertical: myhight * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(widget.selectitem.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Signika Negative',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        Text(widget.selectitem.symbol,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Signika Negative',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                    SizedBox(
                      width: mywight * 0.1,
                    ),
                    Column(
                      children: [
                        Text(
                            '\$' +
                                widget.selectitem.quote.usd.price
                                    .toString()
                                    .substring(0, 12),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Signika Negative',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        Text(
                            widget.selectitem.quote.usd.percentChange24H
                                    .toString() +
                                '%',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Signika Negative',
                              fontWeight: FontWeight.bold,
                              color: widget.selectitem.quote.usd
                                          .percentChange24H >=
                                      0
                                  ? Colors.green
                                  : Colors.red,
                            ))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: myhight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Market Cap',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: myhight * 0.01,
                      ),
                      Text(
                          ' \$' +
                              widget.selectitem.quote.usd.marketCap
                                  .toString()
                                  .substring(0, 9),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Total Supply',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: myhight * 0.01,
                      ),
                      Text(
                          '\$' +
                              widget.selectitem.totalSupply
                                  .toString()
                                  .substring(0, 8),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Percent 90d',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: myhight * 0.01,
                      ),
                      Text(
                          '\$' +
                              widget.selectitem.quote.usd.percentChange90D
                                  .toString()
                                  .substring(0, 8),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.bold,
                            color:
                                widget.selectitem.quote.usd.percentChange90D >=
                                        0
                                    ? Colors.green
                                    : Colors.red,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: myhight * 0.04,
              ),
              Container(
                height: myhight * 0.4,
                width: mywight,
                // color: Colors.yellow,
                child: SfCartesianChart(
                  trackballBehavior: trackballBehavior,
                  zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true, zoomMode: ZoomMode.x),
                  series: <CandleSeries>[
                    CandleSeries<Usd, int>(
                        enableSolidCandles: true,
                        enableTooltip: true,
                        bullColor: Colors.green,
                        bearColor: Colors.red,
                        dataSource: coinModel,
                        xValueMapper: (Usd sales, _) => sales.percentChange1H,
                        lowValueMapper: (Usd sales, _) =>
                            sales.percentChange24H,
                        highValueMapper: (Usd sales, _) =>
                            sales.percentChange7D,
                        openValueMapper: (Usd sales, _) =>
                            sales.percentChange30D,
                        closeValueMapper: (Usd sales, _) =>
                            sales.percentChange60D,
                        animationDuration: 55)
                  ],
                ),
              ),
              SizedBox(
                height: myhight * 0.13,
              ),
              Container(
                height: myhight * 0.1,
                width: mywight,
                child: Column(
                  children: [
                    SizedBox(
                      height: myhight * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: mywight * 0.05,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: myhight * 0.016),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                color: Color(0xFFf7971E)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: myhight * 0.02,
                                ),
                                Text('Add To Portfolio',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Signika Negative',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: myhight * 0.007),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.5),
                            ),
                            child: Image.asset(
                              'assets/images/iconnoti.png',
                              height: myhight * 0.04,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox()
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isRefreshing = true;

  List<Usd> coinModel = [];
  Future<void> getCoinModel() async {
    const url =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=20c54a77-5ee6-45ee-8045-bfce39349a00';
    setState(() {
      isRefreshing = true;
    });
    try {
      var response = await get(Uri.parse(url), headers: {
        "content-Type": 'application/json',
        'Accept': 'application/json',
      });
      setState(() {
        isRefreshing = false;
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        List<dynamic> coinListData = jsonResponse['data'];

        List<Usd> coinModels =
            coinListData.map((coinData) => Usd.fromJson(coinData)).toList();

        setState(() {
          coinModel = coinModels;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}
