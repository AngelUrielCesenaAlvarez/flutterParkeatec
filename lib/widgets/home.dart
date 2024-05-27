import 'package:flutter/material.dart';
import 'package:parkeatec/widgets/profile.dart';
import 'package:parkeatec/widgets/welcome_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexSelector = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [WelcomePage(), Profile()];
    return Scaffold(
        body: screens[indexSelector],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => setState(() {
            indexSelector = value;
          }),
          type: BottomNavigationBarType.shifting,
          currentIndex: indexSelector,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_sharp),
                label: "Profile",
                backgroundColor: Color.fromARGB(255, 70, 40, 167))
          ],
        ));
  }
}
