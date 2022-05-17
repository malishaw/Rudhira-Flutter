import 'dart:async';

import 'package:blooddonateapp/views/colors.dart';
import 'package:blooddonateapp/views/screens/dashboard.dart';
import 'package:blooddonateapp/views/screens/home.dart';

import 'package:blooddonateapp/views/screens/splash_screen.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: SplashScreen()));
}

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
final FirebaseAuth _auth = FirebaseAuth.instance;

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  GoogleSignInAccount? _currentUser;

  var cardTextStyle = const TextStyle(
      fontFamily: "Montserrat Regular",
      fontSize: 14,
      color: Color.fromRGBO(63, 63, 63, 1));

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account!;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      int _current = 0;
      final CarouselController _controller = CarouselController();

      return Scaffold(
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
        body: Home(user: user),
        floatingActionButton: FloatingActionButton(
            backgroundColor: themColor,
            tooltip: 'Dashboard',
            child: const Icon(Icons.dashboard),
            onPressed: (() {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DashboardScreen(user: user);
              }));
            })),
        // bottomNavigationBar: buildMyNavBar(context),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 150,
                height: 150,
                child: Image.asset('assets/images/logow.png')),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'You are not signed in. Please sign with google to continue the app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: signIn,
                color: Colors.blueAccent,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/google.png',
                          height: 30,
                        ),
                        SizedBox(width: 20),
                        const Text("Login with Google",
                            style: TextStyle(color: Colors.white, fontSize: 18))
                      ],
                    )))
          ],
        ),
      );
    }
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn();

      _googleSignIn.onCurrentUserChanged.listen((account) {
        setState(() {
          _currentUser = account!;
        });
      });
      _googleSignIn.signInSilently();
    } catch (e) {
      print('Error signing in $e');
    }
  }

  void signOut() {
    _googleSignIn.disconnect();
    setState(() {});
  }

}
