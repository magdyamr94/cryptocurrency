import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  var item;
  Item(this.item);
  @override
  Widget build(BuildContext context) {
    double myhight = MediaQuery.of(context).size.height;
    double mywight = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: mywight * 0.05, vertical: myhight * 0.03),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: mywight * 0.02),
                Text(item.symbol,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ))
              ],
            ),
          ),
          SizedBox(
            width: mywight * 0.1,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$  ' + item.quote.usd.price.toString().substring(0, 9),
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text('\$ ' + item.quote.usd.volumeChange24H.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Signika Negative',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )),
                    SizedBox(
                      width: mywight * 0.02,
                    ),
                    Text(
                        item.quote.usd.percentChange24H
                                .toString()
                                .substring(0, 6) +
                            '%',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Signika Negative',
                          fontWeight: FontWeight.bold,
                          color: item.quote.usd.percentChange24H >= 0
                              ? Colors.green
                              : Colors.red,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
