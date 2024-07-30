import 'package:flutter/material.dart';

class Climate extends StatefulWidget {
  const Climate({super.key});

  @override
  State<Climate> createState() => _ClimateState();
}

class _ClimateState extends State<Climate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClimateApp'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => print('clicked'),

          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset('images/rain_road.jpg',
              height: 1200,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.fromLTRB(0.0,12.9,20.9,0.0),
            child: Text('Vehari',
            style: cityStyle(),
            ),
          ),
          Center(
            child: Image.asset('images/light_rain1.png',
            height:300 ,
            width: 400,
            ),
          ),
          Center(
            child: Image.asset('images/light_rain.png',
              height:200 ,
              width: 100,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 400, 0.0,0.0),
            child: Text('50.32F',
            style: temStyle(),
            ),
          ),
        ],
      ),
    );
  }
}


TextStyle cityStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic,
  );
}


TextStyle temStyle(){
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 45,
    fontStyle: FontStyle.normal,
  );
}
