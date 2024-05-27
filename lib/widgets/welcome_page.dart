import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int indexSelector = 0;
  int _numberOfVehicles = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _fetchNumberOfVehicles();
    });
  }

  Future<void> _fetchNumberOfVehicles() async {
    try {
      final response = await http.get(
        Uri.parse('http://140.10.4.160:8000/deteccion/detecciones/'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            _numberOfVehicles = data['numero_de_vehiculos'] ?? 0;
          });
        }
      } else {
        throw Exception(
            'Failed to load data: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch number of vehicles. Error: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Number of Vehicles Detected:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_numberOfVehicles',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParkingSpacesScreen(numberOfVehicles: _numberOfVehicles)),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: 267,
                    height: 200,
                    color: Colors.blue, // Color del rectángulo
                    child: Image.asset('assets/images/estacionamiento.jpg'), // Ruta de la imagen
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Estacionamiento de tierra',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParkingSpacesScreen(numberOfVehicles: _numberOfVehicles)),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.green, // Color del rectángulo
                    child: Image.asset('assets/images/user.jpg'), // Ruta de la imagen
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Estacionamiento de pavimento',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParkingSpacesScreen extends StatelessWidget {
  final int numberOfVehicles;

  ParkingSpacesScreen({required this.numberOfVehicles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Spaces'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parking Spaces',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: buildParkingSpaces(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildParkingSpaces() {
    List<Widget> parkingSpaces = [];
    int totalParkingSpaces = 7; // Total number of parking spaces
    for (int i = 0; i < totalParkingSpaces; i++) {
      Color color = i < numberOfVehicles ? Colors.red : Colors.green;
      parkingSpaces.add(
        Container(
          width: 50,
          height: 80,
          margin: EdgeInsets.all(5),
          color: color,
        ),
      );
    }
    return parkingSpaces;
  }
}
