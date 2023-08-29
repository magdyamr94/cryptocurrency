import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:iti/converter.dart';
import 'package:iti/support.dart';
import 'package:iti/view/components/item.dart';
import 'package:iti/view/components/item2.dart';
import 'dart:convert';
import 'Model/coinModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getCoinModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myhight = MediaQuery.of(context).size.height;
    double mywight = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                splashColor: Color(0xFFFFD200),
                icon: Icon(
                  Icons.price_change_outlined,
                ),
                onPressed: () {
                  Get.to(Converter());
                },
              ),
              IconButton(
                splashColor: Color(0xFFFFD200),
                icon: Icon(Icons.contact_support_outlined),
                onPressed: () {
                  Get.to(SupportPage());
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              ;
            },
            child: Icon(
              Icons.home,
              color: Colors.black,
            ),
            backgroundColor: Color(0xFFFFD200),
            elevation: 2.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: myhight,
          width: mywight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Color(0xFFf7971E), Color(0xFFFFD200)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: myhight * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: mywight * 0.015,
                          vertical: myhight * 0.005),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Main Portfolio',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mywight * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CryptoTo',
                      style: TextStyle(
                        fontSize: 27,
                        fontFamily: 'Lilita One',
                      ),
                    ),
                    Container(
                      height: myhight * 0.04,
                      width: mywight * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: Image.asset('assets/images/icon1.png'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mywight * 0.07),
                child: Row(
                  children: [
                    Text(
                      '  Prices,PercentChange24H',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Lilita One',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: myhight * 0.02),
              Container(
                height: myhight * 0.7,
                width: mywight,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          spreadRadius: 8,
                          offset: Offset(
                            0,
                            3,
                          )),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    SizedBox(
                      height: myhight * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mywight * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Signika Negative',
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: myhight * 0.02,
                    ),
                    Expanded(
                      child: isRefreshing == true
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 245, 213, 36)),
                            )
                          : ListView.builder(
                              itemCount: coinModel.length,
                              itemBuilder: (context, index) {
                                return Item(coinModel[index]);
                              },
                            ),
                    ),
                    SizedBox(
                      height: myhight * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: mywight * 0.05),
                      child: Row(
                        children: [
                          Text(
                            'Recommend To Buy',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: 'Signika Negative',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: myhight * 0.22,
                      width: mywight,
                      child: Padding(
                        padding: EdgeInsets.only(left: mywight * 0.03),
                        child: isRefreshing == true
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 209, 182, 26)),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: coinModel.length,
                                itemBuilder: (context, index) {
                                  return item2(
                                    item: coinModel[index],
                                  );
                                }),
                      ),
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
  List<Coin> coinModel = [];
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

        List<Coin> coinModels =
            coinListData.map((coinData) => Coin.fromJson(coinData)).toList();

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
