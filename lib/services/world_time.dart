import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // location name fo the UI
  late String time; // the time i that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  bool isDayTime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url')
      );
      Map data = jsonDecode(response.body);

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDayTime = now.hour > 6 && now.hour < 18;
      time = DateFormat.jm().format(now); //convert to string
    }
    catch(e){
      time = 'could not get time date';
    }
  }
}