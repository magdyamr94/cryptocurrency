import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iti/view/components/selectCoin.dart';

class item2 extends StatelessWidget {
  var item;
  item2({this.item});
  @override
  Widget build(BuildContext context) {
    double myhight = MediaQuery.of(context).size.height;
    double mywight = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mywight * 0.02, vertical: myhight * 0.02),
      child: GestureDetector(
        onTap: () {
          Get.to(SelectCoin(
            selectitem: item,
          ));
        },
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: mywight * 0.02, vertical: myhight * 0.02),
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                border: Border.all(color: Colors.grey)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: mywight * 0.02, vertical: myhight * 0.01),
                  height: myhight * 0.05,
                  child: Text(
                    item.name,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Signika Negative',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(item.symbol,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    )),
                Row(
                  children: [
                    Text(
                        '\$  ' +
                            item.quote.usd.price.toString().substring(0, 7),
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Signika Negative',
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        )),
                    SizedBox(
                      width: mywight * 0.02,
                    ),
                    Text(
                        item.quote.usd.percentChange24H
                                .toString()
                                .substring(0, 4) +
                            '%',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Signika Negative',
                          fontWeight: FontWeight.bold,
                          color: item.quote.usd.percentChange24H >= 0
                              ? Colors.green
                              : Colors.red,
                        ))
                  ],
                ),
                Text(
                    item.quote.usd.volumeChange24H.toString().contains('-')
                        ? '-\$' +
                            item.quote.usd.volumeChange24H
                                .toString()
                                .replaceAll('-', '')
                        : '\$  ' + item.quote.usd.volumeChange24H.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 66, 64, 64),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
