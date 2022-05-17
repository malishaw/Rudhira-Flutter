import 'package:blooddonateapp/views/colors.dart';
import 'package:blooddonateapp/views/screens/dashboard.dart';
import 'package:blooddonateapp/views/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.user}) : super(key: key);
  GoogleSignInAccount user;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC4DFCB),
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: themColor,
      ),
      body: Home(user: widget.user),
      floatingActionButton: FloatingActionButton(
          backgroundColor: themColor,
          tooltip: 'Dashboard',
          child: const Icon(Icons.dashboard),
          onPressed: (() {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DashboardScreen(user: widget.user);
            }));
          })),
      // bottomNavigationBar: buildMyNavBar(context),
    );
  }


}
