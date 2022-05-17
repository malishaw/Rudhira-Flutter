import 'package:blooddonateapp/views/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonationApplicationScreen extends StatefulWidget {
  DonationApplicationScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _DonationApplicationScreenState createState() =>
      _DonationApplicationScreenState();
}

class _DonationApplicationScreenState extends State<DonationApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themColor,
        title: const Text("Donate Blood"),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('blood_donate');

  String _name = '';
  String _email = '';
  int _age = -1;
  String _maritalStatus = 'single';
  int _selectedGender = 0;
  String _password = '';
  bool _termsChecked = true;
  String _nic = '';
  String dropdownValue = 'A-';
  String _city = '';
  String _phone = '';

  String _gender = '';

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('A-'),
      value: 0,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('A+'),
      value: 1,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('B-'),
      value: 2,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('B+'),
      value: 2,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('O-'),
      value: 2,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('O+'),
      value: 2,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('AB-'),
      value: 2,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('AB+'),
      value: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 7, 78, 137),
        width: double.infinity,
        child: const Center(
            child: Text(
          "Donation Application",
          style: TextStyle(color: Colors.white),
        ))));

    formWidget.add(TextFormField(
      decoration:
          InputDecoration(labelText: 'Enter Full Name', hintText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _name = value!;
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: InputDecoration(hintText: 'Age', labelText: 'Enter Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty)
          return 'Enter age';
        else
          return null;
      },
      onSaved: (value) {
        setState(() {
          _age = int.tryParse(value!)!;
        });
      },
    ));

    formWidget.add(TextFormField(
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
          labelText: 'Enter Phone Number', hintText: 'Phone'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter phone number';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _phone = value!;
        });
      },
    ));

    // formWidget.add(DropdownButton(
    //   hint: const Text('Select Blood Group'),
    //   items: genderList,
    //   value: _selectedGender,
    //   onChanged: (value) {
    //     setState(() {
    //       _selectedGender = int.tryParse(value.toString())!;
    //     });
    //   },
    //   isExpanded: true,
    // ));
    // formWidget.add(SizedBox(
    //   height: 20,
    // ));
    formWidget.add(const Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Gender",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      ),
    ));

    formWidget.add(Wrap(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Male'),
          value: 'Male',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Female'),
          value: 'Female',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Other'),
          value: 'Other',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
      ],
    ));

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(hintText: 'NIC', labelText: 'Enter NIC'),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty)
          return 'Enter NIC';
        else
          return null;
      },
      onSaved: (value) {
        setState(() {
          _nic = value!;
        });
      },
    ));
    formWidget.add(const SizedBox(
      height: 25,
    ));
    formWidget.add(Row(
      children: [
        const Text('Select your blood type'),
        const SizedBox(
          width: 15,
        ),
        DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white, //background color of dropdown button
                border: Border.all(
                    color: Colors.black38,
                    width: 3), //border of dropdown button
                borderRadius: BorderRadius.circular(
                    50), //border raiuds of dropdown button
                boxShadow: const <BoxShadow>[
                  //apply shadow on Dropdown button
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                      blurRadius: 5) //blur radius of shadow
                ]),
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(
                    color: Color.fromARGB(255, 13, 8, 23), fontSize: 16),
                underline: Container(
                    // height: 2,
                    // color: Colors.deepPurpleAccent,
                    ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'A-',
                  'A+',
                  'B-',
                  'O-',
                  'O+',
                  'AB-',
                  'AB+',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )),
      ],
    ));
    formWidget.add(const SizedBox(
      height: 25,
    ));
    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          hintText: 'Enter Resident City', labelText: 'Enter Resident City'),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty)
          return 'Enter Resident City';
        else
          return null;
      },
      onSaved: (value) {
        setState(() {
          _city = value!;
        });
      },
    ));

    void onPressedSubmit() async {
      if (_formKey.currentState!.validate() && _termsChecked) {
        _formKey.currentState!.save();

        print("Name " + _name);
        print("Email " + _email);
        print("Age " + _age.toString());
        switch (_selectedGender) {
          case 0:
            print("Gender Male");
            _gender = "Male";
            break;
          case 1:
            print("Gender Female");
            _gender = "Female";
            break;
          case 3:
            print("Gender Others");
            _gender = "Other";
            break;
        }
        print("Marital Status " + _maritalStatus);
        print("Password " + _password);
        print("Termschecked " + _termsChecked.toString());

        await _productss.add({
          "name": _name,
          "age": _age,
          "phone": _phone,
          "bloodType": dropdownValue,
          "gender": _gender,
          "nic": _nic,
          "city": _city,
        });

        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: themColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            child: const Text(
              'Submit',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              onPressedSubmit();
            }),
      ),
    );

    return formWidget;
  }
}
