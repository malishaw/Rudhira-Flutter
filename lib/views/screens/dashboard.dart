import 'package:blooddonateapp/main.dart';
import 'package:blooddonateapp/views/colors.dart';
import 'package:blooddonateapp/views/screens/about_june14.dart';
import 'package:blooddonateapp/views/screens/blood_banks_screen.dart';
import 'package:blooddonateapp/views/screens/blood_request_screen.dart';
import 'package:blooddonateapp/views/screens/donate_date.dart';
import 'package:blooddonateapp/views/screens/donation_application_screen.dart';
import 'package:blooddonateapp/views/screens/home_screen.dart';
import 'package:blooddonateapp/views/screens/user_screen.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({required this.user});
  GoogleSignInAccount user;
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = const TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        backgroundColor: themColor,
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 12, 2, 12),
          child: Column(
            children: [
              ListTileTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                contentPadding: EdgeInsets.all(10),
                iconColor: Color.fromARGB(255, 26, 26, 26),
                textColor: Color.fromARGB(201, 25, 25, 25),
                tileColor: Colors.red.withOpacity(0.3),
                style: ListTileStyle.list,
                dense: true,
                child: ListTile(
                  leading: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return UserScreen(user: widget.user);
                        }));
                      },
                      child: GoogleUserCircleAvatar(identity: widget.user)),
                  title: Text(
                    widget.user.displayName ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(widget.user.email,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800)),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.logout,
                      size: 35,
                    ),
                    onPressed: signOut,
                  ),
                ),
              ),
              const Divider(
                height: 2,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const BloodRequestScreen();
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/requestblood.png',
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Request Blood',
                              style: cardTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return DonationApplicationScreen();
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/donateblood.png',
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Donate Blood',
                              style: cardTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return BloodBanksScreen();
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/bloodbanks.png',
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Blood Banks',
                              style: cardTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return DanateDateScreen(user: widget.user);
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/donatedatesave.jpg',
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Donate Date',
                              style: cardTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const AboutJune14Screen();
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/Aboutjune.jpg',
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'About JUNE 14',
                              style: cardTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return HomeScreen(user: widget.user);
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/home.png',
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Home',
                              style: cardTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ElevatedButton(onPressed: signOut, child: const Text('Sign out'))
            ],
          ),
        ),
      ),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> signOut() async {
    await _auth.signOut().then((_) {
      //try the following
      _googleSignIn.signOut();
      //try the following

      // Navigator.push(context, MaterialPageRoute(builder: (_) {
      //   return Home();
      // }));
      Navigator.pushReplacement(
          (context), MaterialPageRoute(builder: (context) => widget));
    });

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return const InitialPage();
    }));
  }
}
