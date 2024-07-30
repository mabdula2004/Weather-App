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
  String? _cityEntered;

  Future<void> _goToNextScreen(BuildContext context) async {
    Map? results = await Navigator.of(context).push(
      MaterialPageRoute<Map>(
        builder: (BuildContext context) {
          return ChangeCity();
        },
      ),
    );

    if (results != null && results.containsKey('enter')) {
      setState(() {
        _cityEntered = results['enter'];
      });
    }
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
            onPressed: () {
              _goToNextScreen(context);
            },
          ),
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
              '${_cityEntered==null ? defaultCity: _cityEntered}',
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
            margin: EdgeInsets.fromLTRB(20, 220, 0.0, 0.0),
            child: updateTempWidget('${_cityEntered==null ? defaultCity: _cityEntered}'),
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

  Widget updateTempWidget(String city) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getWeather(apiId, city),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data!;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(
                    "${content['main']['temp']} °F",
                    style: temStyle(),
                  ),
                  subtitle: ListTile(
                    title: Text(
                      "Humidity: ${content['main']['humidity']}\n"
                          "Min: ${content['main']['temp_min']} °F\n"
                          "Max: ${content['main']['temp_max']} °F",
                      style: extraData(),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class ChangeCity extends StatelessWidget {
  final TextEditingController _cityFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Change City'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              'images/snow_road.png',
              width: 400.0,
              height: 350.0,
              fit: BoxFit.fill,
            ),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  controller: _cityFieldController,
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                  ),
                ),
              ),
              ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {'enter': _cityFieldController.text});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: Text('Get Weather'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 45,
    fontStyle: FontStyle.normal,
  );
}

TextStyle extraData() {
  return TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 17.0,
  );
}
