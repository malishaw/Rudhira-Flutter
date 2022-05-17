import 'package:blooddonateapp/views/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key, required this.user}) : super(key: key);

  GoogleSignInAccount user;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  addUsertoFirebase();
  }

  Future<void> addUsertoFirebase() async {
    await _productsss.add({
      "id": "1",
      "username": widget.user.displayName,
      "useremail": widget.user.email,
      "age": "",
      "bloodType": "",
      "nic": " ",
      "city": " ",
    });
  }

  final CollectionReference _productsss =
      FirebaseFirestore.instance.collection('user');

  Future<void> updateUsertoFirebase(
      String age, String bloodType, String city, String nic) async {
    await _productsss.doc(widget.user.id).update({
      "username": widget.user.displayName,
      "useremail": widget.user.email,
      "age": age,
      "bloodType": bloodType,
      "nic": nic,
      "city": city,
    });
  }

  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final GlobalKey<ScaffoldState> _mainScaffoldKey =
      new GlobalKey<ScaffoldState>();

  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  String dropdownValue = 'Blood Group A';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: themColor,
          title: Text(widget.user.displayName.toString()),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              GoogleUserCircleAvatar(identity: widget.user),
              const SizedBox(
                height: 20,
              ),
              Text(widget.user.displayName.toString()),
              Text(widget.user.email.toString()),
              const SizedBox(
                height: 20,
              ),
              // TextField(
              //   controller: _ageController,
              //   decoration: const InputDecoration(
              //       labelText: 'Enter Age',
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color: Color.fromARGB(255, 90, 90, 90), width: 2.0),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: themColor, width: 2.0),
              //       )),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // TextField(
              //   controller: _nicController,
              //   decoration: const InputDecoration(
              //       labelText: 'Enter NIC',
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color: Color.fromARGB(255, 90, 90, 90), width: 2.0),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: themColor, width: 2.0),
              //       )),
              // ),

              // const SizedBox(
              //   height: 15,
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // //blood types dropdown
              // DropdownButton<String>(
              //   value: dropdownValue,
              //   icon: const Icon(Icons.arrow_drop_down),
              //   elevation: 16,
              //   style: const TextStyle(
              //       color: Color.fromARGB(255, 13, 8, 23), fontSize: 16),
              //   underline: Container(
              //       // height: 2,
              //       // color: Colors.deepPurpleAccent,
              //       ),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       dropdownValue = newValue!;
              //     });
              //   },
              //   items: <String>[
              //     'Blood Group A',
              //     'Blood Group B',
              //     'Blood Group AB',
              //     'Blood Group O'
              //   ].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // TextField(
              //   controller: _cityController,
              //   decoration: const InputDecoration(
              //       labelText: 'Enter City',
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color: Color.fromARGB(255, 90, 90, 90), width: 2.0),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: themColor, width: 2.0),
              //       )),
              // ),

              // const SizedBox(
              //   height: 15,
              // ),

              // ElevatedButton(
              //     child: Text('Update'),
              //     onPressed: () async {
              //       final String age = _ageController.text;
              //       final String city = _cityController.text;
              //       final String nic = _cityController.text;
              //       final String bloodType = dropdownValue;
              //       // await updateUsertoFirebase(
              //       //     age, bloodType, city, nic);
              //     })
            ],
          ),
        ));
  }
}
