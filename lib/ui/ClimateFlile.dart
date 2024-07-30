import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/ApiFlie.dart';

class Climate extends StatefulWidget {
  const Climate({super.key});

  @override
  State<Climate> createState() => _ClimateState();
}

class _ClimateState extends State<Climate> {
  void showStuff() async {
    Map data = await getWeather(apiId, defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClimateApp'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => showStuff(),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'images/rain_road.jpg',
              height: 1200,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.fromLTRB(0.0, 12.9, 20.9, 0.0),
            child: Text(
              'Vehari',
              style: cityStyle(),
            ),
          ),
          Center(
            child: Image.asset(
              'images/light_rain1.png',
              height: 300,
              width: 400,
            ),
          ),
          Center(
            child: Image.asset(
              'images/light_rain.png',
              height: 100,
              width: 80,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(35, 385, 0.0, 0.0),
            child: Text(
              '50.32F',
              style: temStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> getWeather(String appId, String city) async {
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId&units=metric';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'error': 'Error: ${response.statusCode}, ${response.reasonPhrase}'
        };
      }
    } catch (e) {
      return {'error': 'An exception occurred: $e'};
    }
  }
}

TextStyle cityStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic,
  );
}

TextStyle temStyle() {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 45,
    fontStyle: FontStyle.normal,
  );
}
