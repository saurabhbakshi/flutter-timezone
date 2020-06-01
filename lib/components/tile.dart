import 'package:flutter/material.dart';
import 'package:time_zone/components/regionalTime.dart';
import 'package:time_zone/constant.dart';

class Tile extends StatefulWidget {
  final String timezone;
  final removeTile;
  Tile({this.timezone, this.removeTile});

  @override
  _TileState createState() => _TileState(this.timezone, this.removeTile);
}

class _TileState extends State<Tile> {
  final String timezone;
  final removeTile;
  _TileState(this.timezone, this.removeTile);
  RegionalTime time;
  initState() {
    super.initState();
    time = RegionalTime(timeZone: timezone);
    updateTime();
  }

  void updateTime() async {
    await time.getTime();
    setState(() {
      time = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    updateTime();
    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xff616161)),
      // padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              // mainAxisAlignment:,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  time.city,
                  style: kTileLabel,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time.timeAbbrevation,
                  style: kTileLabel.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Divider(
            color: kDividerColor,
            thickness: 1,
            height: 10,
            // indent: 10,
            // endIndent: 10,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(time.time,
                          textAlign: TextAlign.center, style: kNumberLabel),
                      Text(
                        "Time",
                        style: kTileLabel.copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(time.utcOffset,
                          textAlign: TextAlign.center, style: kNumberLabel),
                      Text(
                        "Offset",
                        style: kTileLabel.copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                // Text(
                //   time.utcOffset,
                //   style: kTileLabel,
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
          ),
          // Divider(
          //   color: kDividerColor,
          //   thickness: .5,
          //   height: 5,
          //   // indent: 10,
          //   // endIndent: 10,
          // ),
          Container(
            decoration: BoxDecoration(
              color: kSecondaryText,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.language,
                        color: kDividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          time.region,
                          style: kTileLabel.copyWith(
                              fontSize: 16, color: kDividerColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      removeTile(timezone);
                    },
                    child: Icon(
                      Icons.remove_circle,
                      color: kDividerColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
