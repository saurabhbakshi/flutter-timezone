import 'package:http/http.dart' as http;
import 'dart:convert';

class RegionalTime {
  String date;
  String time;
  String timeAbbrevation;
  String timeZone;
  String region;
  String city;
  String utcOffset;
  final String url = "http://worldtimeapi.org/api/timezone/";
  RegionalTime(
      {this.timeZone,
      this.time = '',
      this.date = '',
      this.timeAbbrevation = '',
      this.utcOffset = '',
      this.city = '',
      this.region = ''});
  Future getTime() async {
    http.Response response;
    try {
      response = await http.get(url + timeZone);
      if (response.statusCode == 200) {
        timeAbbrevation = jsonDecode(response.body)['abbreviation'];
        utcOffset = jsonDecode(response.body)['utc_offset'];
        String temp = jsonDecode(response.body)['datetime'];
        date = temp.split('T')[0];
        time = temp.split('T')[1].split('.')[0];
        region = timeZone.split('/')[0];
        city = timeZone.split('/')[1];
      }

      // return timeDataObject=TimeData.withValues();

    } catch (e) {
      print(response.statusCode);
    }
  }
}
