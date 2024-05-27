import 'package:flutter/material.dart';
import 'login_page.dart';
import 'authentication.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.jpg"),
              radius: 80,
            ),
            SizedBox(height: 20),
            Text(
              "Irancito",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Ejemplo@yahoo.com"),
            Text("Ensenada B.C."),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                _auth.logout();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Cerrar sesión'),
            )
          ],
        ),
      ),
    );
  }
}
