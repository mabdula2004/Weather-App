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
        ],
      ),
    );
  }
}
