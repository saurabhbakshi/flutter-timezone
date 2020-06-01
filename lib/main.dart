import 'package:flutter/material.dart';
import 'package:time_zone/constant.dart';
import 'package:time_zone/components/tile.dart';
import 'package:time_zone/util/dbhelper.dart';

import 'models/timzone.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<TimeZone> dbRegion = List<TimeZone>();
    // DbHelper helper = DbHelper();
    // helper.initializeDb().then(
    //     (result) => {helper.getTimeZone().then((result) => dbRegion = result)});

    // TimeZone testZone = TimeZone("Asia", "Kolkata", "Asia/Kolkata", "IST");
    // helper.insertTimeZone(testZone);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('TimeZones'),
        ),
        body: SafeArea(child: MyApp()),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  DbHelper helper = DbHelper();
  List selectedTiles = [];
  int regionCount = 0;
  String defaultValue = "Asia/Kolkata";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (selectedTiles.length == 0) {
      getData();
    }
    // setState(() {
    //   selectedTiles.add(defaultValue);
    // });
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        print('Widget Paused');
        break;
      case AppLifecycleState.inactive:
        print('Widget Inactive');
        break;
      case AppLifecycleState.resumed:
        print('Widget Resumed');
        setState(() {
          selectedTiles = selectedTiles;
        });
        break;
      case AppLifecycleState.detached:
        print('Widget Detatched');
        break;
    }
  }

  void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final timeZoneFuture = helper.getTimeZone();
      timeZoneFuture.then((result) {
        List<TimeZone> timeZones = List<TimeZone>();
        regionCount = result.length;
        for (int i = 0; i < regionCount; i++) {
          timeZones.add(TimeZone.fromObject(result[i]));
        }

        for (int i = 0; i < timeZones.length; i++) {
          setState(() {
            selectedTiles.add(timeZones[i].timezone);
          });
        }
      });
    });
  }

  List<Widget> showTiles() {
    List<Widget> tiles = List<Widget>();
    if (selectedTiles.length == 0) {
    } else {
      selectedTiles.forEach((element) {
        tiles.add(Tile(
          timezone: element,
          removeTile: removeTile,
        ));
      });
    }
    return tiles;
  }

  void addTiles(String timezone) {
    TimeZone selectedZone = TimeZone(timezone);
    helper.insertTimeZone(selectedZone).then((result) => {
          setState(() {
            selectedTiles.add(timezone);
          })
        });
  }

  void removeTile(String timezone) {
    helper.deleteTimeZone(timezone).then((result) => {
          setState(() {
            selectedTiles.remove(timezone);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: <Widget>[
              DropdownButton<String>(
                isExpanded: false,
                elevation: 8,
                style: kLabelStyle,
                items: kRegions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: defaultValue,
                onChanged: (String value) {
                  setState(() {
                    defaultValue = value;
                  });
                },
              ),
              RoundIconButton(
                icon: Icons.add,
                onPress: () {
                  if (!selectedTiles.contains(defaultValue)) {
                    addTiles(defaultValue);
                    // setState(() {
                    //   selectedTiles.add(defaultValue);
                    // });
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            scrollDirection: Axis.vertical,
            children: showTiles(),
          ),
        )
      ],
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final Function onPress;
  final IconData icon;
  RoundIconButton({@required this.onPress, @required this.icon});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        elevation: 6.0,
        onPressed: onPress,
        shape: CircleBorder(),
        constraints: BoxConstraints.tightFor(height: 36, width: 36),
        fillColor: Color(0xFF4C4F5E),
        child: Icon(icon, size: 22, color: kPrimaryText));
  }
}
